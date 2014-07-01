---
layout: post
title:  "Por que escolher o Xamarin?"
date:   2014-06-25 14:17:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile 
---

Uma dúvida comum quando começamos um novo projeto mobile é a escolha da estratégia a ser seguida, devemos desenvolver uma webapp? Devemos desenvolver uma aplicação híbrida com PhoneGap? Ou devemos optar por aplicações nativas e desenvolvermos uma versão específica para cada plataforma?

Cada uma dessas estratégias traz vantagens e desvantagens que devem ser pensadas de acordo com as características da aplicação a ser desenvolvida assim como o conhecimento da equipe que irá desenvolve-la. Exemplos de caracerísticas que devem ser analisadas são:

* A aplicação usará funções nativas do aparelho?
* Recursos disponíveis (tempo, dinheiro)
* Conhecimento da equipe (Objective-C? Java? C#? Javascript? HTML5? CSS3?)
* Exigência e expectativa dos usuários
* Performance

#### Por que escolher web apps ou híbridas?

Web apps ou híbridas são mais rápidas e fáceis de serem desenvolvidas visto que será desenvolvido apenas um código fonte que será consumido através dos browsers de cada plataforma, no caso das web apps, ou será empacotado de forma (quase) nativa para cada plataforma, no caso das aplicações híbridas.

As skills necessárias para desenvolver aplicações como essas (HTML5, CSS3 e Javascript) são também faceis de serem encontradas visto que são skills também utilizadas no desenvolvimento web, barateando dessa forma o custo e a manutenção das aplicações.

Na minha visão, esse tipo de estratégia é ideal para aplicações que devem ser desenvolvidas com prazo e recursos limitados e para usuários que não exigem que essas aplicações possuam as mesmas caractéristicas que as aplicações que ele já está acostumado a utilizar nos seus dispositivos.

O tipo de recurso que vai ser usado na aplicação também influencia diretamente nessa escolha, web apps ou apps híbridas [não possuem acesso a APIs nativas do aparelho.][1]

 Caso essas aplicações móveis continuem ganhando importância no negócio da empresa, ou novos recursos sejam necessários, eu aconselharia a migração dessas para aplicações nativas.

#### Por que escolher aplicações nativas?

Na minha opinião, as aplicações nativas são muito superiores do que as não nativas. 

Tempo de resposta, aparência, possibilidade de usar os recursos mais avançados da plataforma assim que são lançados e a própria familiaridade que os usuários já possuem ao usar as aplicações nativas dos seus dispositivos são características importantes para o usuário final e que possuem influência no sucesso ou não de um aplicativo. 

Dessa forma, acredito que as aplicações nativas devem ser sempre o objetivo final para estratégias mobile que venham a obter sucesso, no entanto, desenvolver e principalmente manter aplicações nativas é algo que demanda bastante esforço. As vantagens e desvantagens devem ser analisadas com cuidado afim de maximizar o retorno sobre o investimento.

##### Múltiplas Linguagens de Programação 

Desenvolver para as 3 principais plataformas mobile (Android, iOS e Windows Phone) exige que sejam criadas codebases totalmente diferentes e em linguagens de programação também diferentes, Java para Android, Objective-C para iOS, C# para Windows e talvez mais uma linguagem server side, caso seja necessária a integração com algum servidor, ou seja, o trabalho/custo acaba se multiplicando.

##### Múltiplos Desenvolvedores

Trabalhando com diferentes linguagens de programação surge a necessidade de se também trabalhar em times com múltiplos de desenvolvedores, ou seja, múltiplas fontes de custos, aumentamos também a concentração de conhecimento, visto que cada desenvolvedor saberá o suficiente pra trabalhar na sua plataforma e na sua linguagem de programação. Não só isso, na saída de qualquer um dos desenvolvedores, ainda existirá a difícil tarefa de se encontrar um desenvolvedor com as mesmas skills do desenvolvedor que está saindo, skill essas, diga-se de passagem, que não serão encontradas nem mesmo dentro da própria equipe.

##### Não existe reuso e nem compartilhamento de conhecimento

Sabe aquela biblioteca super bacana que o desenvolvedor de iOS criou? Aquele outro projeto open source escrito em Java? Ambos terão que ser portados ou substituídos por outros similares para cada outra plataforma.

#### E se pudessmos juntar os dois mundos?

E se pudessemos desenvolver aplicações em uma única linguagem, e ainda sim, aproveitar o que há de melhor nas aplicações nativas? O Xamarin visa preencher essa lacuna no mercado mobile.

---

## Xamarin, desenvolvimento mobile multi-plataforma

O Xamarin é uma solução mista entre a estratégia híbrida e estratégia nativa, com o Xamarin nós conseguimos escrever código C# que irá ser quase que totalmente reaproveitado entre as diferentes plataformas garantindo o reaproveitamento e unicidade da base de código assim como a experiência de se usar aplicações nativas.

#### Uma Única linguagem

O Xamarin permite que escrevamos código em apenas uma linguagem isso elimina todos os problemas que citei anteriormente. Com o Xamarin podemos ter uma equipe mais homogênea, onde todos os desenvolvedores (Android, iOS e Windows Phone) podem compartilhar conhecimento assim como também código entre si. Buscar um novo desenvolvedor mobile para a equipe nunca foi tão fácil.

#### Interface Nativa

O código escrito em C# não é totalmente reaproveitado entre as plataformas e isso é uma vantagem, sabe por quê? Porque justamente a parte do código que não será reaproveitada será a parte responsável por garantir que as aplicações possuam a experiência nativa e em conformidade com os guias de interface e funcionalidade presentes nas aplicações que os usuários já estão acostumados a utilizar. A figura abaixo mostra como isso funciona.

![Xamarin Diagram](http://xamarin.com/content/images/pages/platform/code-sharing.png)

#### Sempre atualizado em relação às APIs nativas

O Xamarin fornece um espelho de todas as APIs tanto do Android quanto do iOS. Essa API é tão bem feita que podemos inclusive tirar dúvidas ou ler tutoriais utilizando a linguagem nativa da plataforma (Java e/ou Objective-C) e apenas converter o código para o C#. A velocidade de atualização do Xamarin em relação aos novos lançamentos das plataformas nativas também é bastante rápida.

#### Reaproveite sua Equipe

Para a OnceDev e para os nossos clientes esse foi um ponto bastante favorável. Se já possuímos bons desenvolvedores C# com anos de experiênciadesenvolvendo para web/desktop, por que não aproveitar esse conhecimento só que dessa vez para a plataforma mobile? Muito melhor que força-los a aprender novas linguagens de programação apenas para esse intuito.

#### Reaproveite suas Ferramentas

O Xamarin se integra perfeitamento com o Visual Studio e consequentemente com o Windows, então somos capazes de reaproveitar o mesmo conjunto de ferramentas que nós já utilizamos quando estamos desenvolvendo para web como o TFS e o Resharper. A nova versão do Xamarin, inclusive, também trouxe plugins para que a construção das interfaces também possa ser feita através do próprio Visual Studio!

#### Custos

O único ponto desfavorável ao utilizar o Xamarin são os custos, as licensas custam $100, $300 e $999, para as versões de estudante, indie e enterprise, respectivamente, para cada plataforma e por ano. No entanto, com a valorização cada vez maior dos desenvolvedores de software, as licensas passaram a não ter um custo tão relevante, por exemplo, duas licensas (iOS e Android) custariam menos que o salário mensal de um desenvolvedor. 

## Conclusão

Apostar no Xamarin tem sido uma escolha acertada para a OnceDev, fomos capazes de utilizar todo o conhecimento e as ferramentas que nós já possuíamos como desenvolvedores C# só que dessa vez aplicadas a plataforma mobile. Também percebemos um aumento de produtividade e de reuso de código o que nos possibilitou confeccionar propostas mais vantajosas para nossos clientes. Definitivamente, é algo que iremos colocar bastante esforços nos próximos meses. 

[1]: http://www.tigerspike.com/news/2013/11/11/html5-vs-native-apps-new-research-finds-that-many-key-apis-are-native-only/
