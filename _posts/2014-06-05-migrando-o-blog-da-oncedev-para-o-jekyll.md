---
layout: post
title:  "Migrando o blog da OnceDev para o Jekyll"
date:   2014-06-05 17:17:00
author: luizromario
categories: Jekyll
tags: Jekyll Blog Ruby
---

Este blog, o blog da OnceDev, até o momento em que este artigo estava sendo escrito, era uma instância do Wordpress. Nessa semana, decidimos migrá-lo para o Jekyll. Neste artigo, o primeiro escrito "em Jekyll", conto como foi a minha experiência.

___

Jekyll?
===

O [Jekyll](http://jekyllrb.com/) é um gerador de páginas HTML estáticas feito em Ruby que, basicamente, separa a estrutura básica e componentes comuns do site em templates e o seu conteúdo em arquivos de texto simples ou numa linguagem de Markdown simples -- como é dito no próprio slogan: *"Transforme seu texto simples em páginas estáticas e blogs"*. Além disso, ele é *blog-aware*: de fábrica, é possível criar postagens, fazer layouts, categorias, etc..

Por que usar o Jekyll?
---

Se o blog antigo já estava rodando e funcionando, pra que mudar para um novo sistema, trazendo o custo de se aprender uma nova tecnologia e, potencialmente, novos problemas?

Um dos problemas do Wordpress é que é necessário se configurar um banco de dados, realizar configurações, dentre outras coisas. Num blog, que o conteúdo, nunca editado por quem o acessa, é quase todo texto estático, um sistema como o Wordpress é um exagero. Já o Jekyll, por ser um gerador de HTML estático que obtém todo o conteúdo de arquivos de texto simples, não necessita de banco de dados nem de nenhuma configuração especial para a publicação do blog: basta gerá-lo e hospedar o conteúdo gerado no servidor.

Além de a própria arquitetura do Jekyll ser bastante simples, as tecnologias utilizadas por ele, como o [Markdown](http://daringfireball.net/projects/markdown/) e o [Liquid](http://liquidmarkup.org/), são também bastante simples, o que torna a adaptação ao novo sistema bem suave -- me bastou apenas metade de um dia para, sem saber nada, começar a adaptar o blog antigo. Os problemas em potencial trazidos pelo Jekyll são bem menores que os problemas já existentes na então implementação atual.

Migrando o blog
===

Já que parecia valer tanto a pena, começamos a migrar o blog para a nova plataforma. Aqui, descreverei de maneira breve e aproximada como o processo de migração foi para mim. A documentação completa está disponível [no site do Jekyll](http://jekyllrb.com/docs/quickstart/) e é possível pedir ajuda no [repositório de ajuda](https://github.com/jekyll/jekyll-help/) no Github (em inglês).

Criando o novo blog
---

Antes de começar, é necessário criar um esqueleto a partir do qual se irá trabalhar. O Jekyll faz isso pelo comando `jekyll new nome-do-blog`. Depois de executado, ele gera uma pasta com a seguinte estrutura:

    nome-do-blog/
      about.md
      _config.yml
      css/
        main.css
      feed.xml
      _includes/
        footer.html
        header.html
        head.html
      index.html
      _layouts/
        default.html
        page.html
        post.html
      _posts/
        2014-06-05-welcome-to-jekyll.markdown

Por padrão, o Jekyll já gera um blog de exemplo bem básico para o usuário ter uma ideia de como as coisas funcionam. Para gerar o site e executá-lo localmente, basta rodar `jekyll serve` -- o site é gerado na pasta `_site` e fica disponível no endereço `http://0.0.0.0:4000/`.

Funcionamento do Jekyll
---

Para transformar todos esses arquivos em um conjunto de páginas HTML estáticas, alguns dos arquivos e diretórios acima têm uma função especial.

* `_config.yml`: Configurações do site.
* `_posts`: O conteúdo dos artigos. Além do próprio texto dos artigos, é aqui que são definidas a data, as tags, as categorias, o título, etc.. O Jekyll gera um artigo de exemplo escrito em Markdown, mas também é possível usar o [Textile](http://txstyle.org/) ou até mesmo HTML puro -- o que é bastante útil no caso de uma migração em que as postagens antigas do blog estão todas em HTML.
* `_layouts`: Aqui ficam os layouts disponíveis para se atribuir a posts, páginas e até mesmo outros layouts. Isso torna bastante fácil a criação de hierarquias de layouts, se necessário.
* `_includes`: Includes são "pedaços" de páginas (conhecidos por alguns como "parciais" ou "partials") que podem ser incluídos em páginas e layouts.

Todos os arquivos que contém *Front Matter* serão processados pelo Jekyll como templates e gerados no `_site` como páginas. Os demais arquivos são copiados sem nenhuma modificação para lá. Mais detalhes sobre a estrutura de diretórios [aqui](http://jekyllrb.com/docs/structure/).

### Front Matter

O *[Front Matter](http://jekyllrb.com/docs/frontmatter/)* é um cabeçalho no formato YAML presente em todos os arquivos que irão sofrer algum processamento pelo Jekyll -- páginas, posts, layouts, etc.. Por exemplo:

    ---
    layout: post
    title:  "Welcome to Jekyll!"
    date:   2014-06-05 17:53:30
    categories: jekyll update
    ---

Esse é o cabeçalho do post de exemplo gerado pelo Jekyll. Ele define o layout da página gerada, o título do artigo, a data e as categorias. Algumas dessas propriedades serão lidas internamente pelo Jekyll, mas todas podem ser acessadas pela variável global `page`.

### Templates e variáveis

Todos os templates do projeto têm acesso a algumas variáveis globais. As mais importantes são:

* `site`: Contém informações e configurações do site, além dos [dados inseridos em `_data`](http://jekyllrb.com/docs/datafiles/).
* `page`: Contém informações da página e dados inseridos no Front Matter.

Para usar o valor de uma variável no template, basta colocá-lo entre `{% raw %}{{}}{% endraw %}`:

    <title>{% raw %}{{ page.title }}{% endraw %}</title>

Também é possível realizar operações lógicas com os templates (loops, ifs, etc.). Essas ficam entre `{% raw %}{%%}{% endraw %}`:

    {% raw %}
    {% for p in site.posts %}
    <p>{{ post.title }}</p>
    {% endfor %}
    {% endraw %}

Mais detalhes sobre a linguagem de templates Liquid [aqui](http://docs.shopify.com/themes/liquid-basics).

Finalmente, a migração
---

Como o blog antigo já tinha os estilos e os layouts prontos, migrar o blog foi quase trivial. Primeiramente, todas as folhas de estilo, scripts e outros conteúdos foram movidos para uma pasta chamada `content` e, nos layouts, todos os links foram modificados para referenciar essa página -- afinal, o Jekyll simplesmente a copia no site gerado.

Depois, tivemos que adaptar os layouts do blog antigo para o Jekyll. Como o blog antigo usava um framework com operações parecidas com as dos templates do Jekyll, em vários casos, bastou apenas substituir-se a sintaxe antiga pela nova e usar as variáveis já fornecidas pelo Jekyll, em vez de as variáveis passadas pelo controller do site. Um ponto dificultador é que havia bastante repetição de código nos layouts do blog antigo, então tive que gastar algum tempo quebrando os layouts em parciais para eliminar a repetição de código.

Depois de algumas poucas horas, o blog já estava parcialmente migrado. Ainda faltavam algumas coisas, mas o layout já estava pronto.

Agora, era necessário se criar páginas para os posts de cada uma das categorias do blog. Felizmente, já existe um plugin para essa finalidade -- um [gerador de arquivos de categorias](https://github.com/shigeya/jekyll-category-archive-plugin).

Depois, era necessário inserir informações sobre o autor de cada post no final deste. Para isso, com a ajuda do [budparr](https://github.com/budparr) no [jekyll-help](https://github.com/jekyll/jekyll-help/) (valeu, cara) eu criei um `authors.yml` no `_data` e referenciei apenas o id do autor no cabeçalho do artigo (mais detalhes da solução completa [aqui](https://github.com/jekyll/jekyll-help/issues/65)).

Finalmente, para copiar os posts, bastou copiar o conteúdo antigo em HTML mesmo e criar templates HTML dentro de `_posts` com o conteúdo antigo, bastando, apenas, inserir um cabeçalho *Front Matter* em cada um dos artigos para que eles sejam processados pelo Jekyll.

Hospedando no Github
---

Depois de pronto, decidimos hospedar o site como uma [página do Github](https://pages.github.com/), já que páginas do Github podem ser facilmente hospedadas a partitr de um repositório git no próprio Github e suportam Jekyll. Porém, um problema das páginas do Github é que elas não suportam plugins e isso acabou comprometendo as páginas de categorias. A solução (encontrada [aqui](http://arademaker.github.io/blog/2011/12/01/github-pages-jekyll-plugins.html)) foi deixar a página estática gerada pelo Jekyll no ramo `master` do repositório e o código, num outro ramo chamado `source`. Isso deixou a geração do conteúdo do site um tanto menos conveniente, mas eu escrevi um [script](https://github.com/Oncedev/oncedev.github.io/blob/source/jekyll-build.sh) para amenizar a situação.

Resultado
===

Apesar de alguns problemas, a migração foi feita com sucesso em um dia e meio e a hospedagem, em mais um dia. Agora, além de o site estar mais fácil de se manter, ele está muito mais leve.

Portanto, por essa experiência, recomendo o Jekyll para todos que querem fazer um blog ou um site estático simples.

Até.