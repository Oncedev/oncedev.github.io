---
layout: post
title:  "ASP.NET vNext - Game Changer ou Atualização Técnica"
date:   2014-08-14 18:17:00
author: pauloortins
categories: ASPNET
tags: csharp aspnet vnext 
---

Nos últimos anos algumas coisas realmente interessantes e empolgantes vêm acontecendo no mundo ASP.NET. Aqueles que lembram da tecnologia do tempo em que ela tentava tornar stateful o desenvolvimento web, podem se surpreender com algumas opções que temos hoje em dia.

## ASP.NET MVC

Quem acompanha o desenvolvimento recente do ecossistema já percebeu que a Microsoft vem apostando quase todas as fichas no [ASP.NET MVC][1] (não confunda com WebForms). Sem dúvida a criação e disponibilização desse framework foi uma resposta técnica aos anseios da comunidade e a outras linguagens+frameworks que mostraram grande evolução nos últimos anos.

## ASP.NET VNEXT

O ASP.NET vNEXT não é uma mudança apenas no framework como alguns pensam, é uma serie de alterações que abrem as portas para melhorias em todo o ciclo de desenvolvimento. O MVC 6 por exemplo, que é parte da iniciativa do vNEXT, traz melhorias fundamentais e que mudam toda a forma como a Microsoft trabalha seu framework e o deploy em seus servidores. 

### MVC 6

O principal objetivo do ASP.NET MVC 6 é ser “host agnostic” e independente do System.Web. Essa biblioteca que durante muito tempo foi o principal pilar de todo o framework ASP.NET, hoje causa muitos transtornos para a evolução do framework. Para se ter uma ideia do que estou falando, basta olhar o HttpContext, que é um objeto criado no inicio de toda requisição web do framework. Hoje esse objeto(o grafo inteiro do objeto) causa um overhead de 30k em todas as requisições web. Na nova versão isso será diminuído para cerca de 2k por request, com objetos planos e estruturas estilo JSON. Essa mudança obviamente envolverá quebra de compatibilidade com as versões atuais porque alguns métodos e objetos presentes no HttpContext deixarão de existir e outros serão migrados para pacotes opcionais.

Outro ponto muito comentado e útil para o desenvolvimento no dia a dia é a junção dos frameworks de [Web Pages][2], [Web API][3] e [MVC][4]. A algum tempo já é possível usar todos juntos no mesmo projeto, porem eles implementam heranças diferentes e usam classes diferentes para determinados fins, o que torna a manutenção de um projeto sofrível. Agora todos eles utilizarão a mesma infraestrutura de classes.

### TRUE SIDE-BY-SIDE DEPLOYMENT

Uma das features mais importantes do vNext, na minha opinião, é que agora a publicação vai suportar “side-by-side deployment”. Isso quer dizer que a aplicação que você publicar não estará diretamente dependente das versões de DLL no [GAC][5], ou seja, você vai poder ter uma aplicação rodando MVC na versão 6 e outra rodando MVC na versão 7, sem impacto nenhum para qualquer uma das duas, já que agora as referências do framework ficarão junto com cada aplicação e não em um lugar compartilhado, como era o caso do GAC. Será possível atualizar o servidor sem que qualquer das suas aplicações sofram impacto.

## MUDANÇA NO FUTURO DA PLATAFORMA

A Microsoft apresentou mudanças significativas em 7 areas. Algumas delas são atualizações tecnológicas, outras são inovações que afetam apenas concorrentes do mesmo segmento e outras podem realmente mudar todo o mercado. Ou não!

### MODULARIZAÇÃO

Existiu um grande esforço(ainda não finalizado) para efetuar mudanças e deixar o desenvolvimento cada vez mais modular. Nesse ponto a atualização tecnológica pode deixar pra traz concorrentes do segmento coorporativo como o Java. Muitas coisas novas com o KPM são “cópias” de ideias bem sucedidas em outros ecossistemas, que estão sendo melhoradas ou adaptadas ao mundo .NET. O Nuget que em parte já fazia esse papel agora é o coração do novo Katana Package Manager(KPM). 
Houve também uma mudança na estratégia de dependências. Agora os projetos não referenciam mais “Libraries” e sim “Packages”. A maior diferença com isso é que um Package pode conter múltiplas Libraries e até versões diferentes de Libraries de acordo com a plataforma-alvo.

### CICLO DE DESENVOLVIMENTO MAIS RÁPIDO

Com as mudanças no processo de build, deploy via power shell e mudança de algumas APIs do framework, não tivemos só aumento na velocidade no desenvolvimento e deploy mas também total desacoplamento do Visual Studio no caso do deploy por exemplo. Conheço muita gente que não via com bons olhos o processo de publish ser tão acoplado a ferramenta. Sempre houveram alternativas para publicação, mas cabia a cada desenvolvedor criar sua solução. Agora teremos um suporte maior a publish desacoplado do Visual Studio vindo da própria Microsoft. 

### TRANSIÇÃO SUAVE ENTRE ON-PREMISES E CLOUD

Não ter um dependência com System.Web ajuda a melhorar as coisas, mas a Microsoft foi além e otimizou ainda mais algo que eles estão chamando de “Cloud Optimized Framework”. Com esse framework otimizado para nuvem você perde ainda mais funcionalidades e APIs, como é o caso do System.Drawing. Tudo para deixar a aplicação ainda mais portável e “host agnostic”. 

![ASP.NET Stack ][13]

A grande vantagem de usar de usar essa abordagem é que dessa forma o Core(ou Mono) CLR é publicado junto com a sua aplicação, você não vai mais precisar atualizar a versão do CLR da sua maquina host ou se preocupar com websites diferentes rodando sobre versões diferentes de CLR. 

## CONCLUINDO...

Ainda existem muitas outras coisas para serem faladas a respeito do vNEXT, mas uma das coisas que pode mudar o jogo a favor da Microsoft nos próximos anos é o “desapego” as suas próprias ferramentas e plataformas. O vNEXT entrega novamente o poder ao desenvolvedor ou gestor de escolher suas próprias plataformas e ferramentas. Não existe mais dependência com Visual Studio, não existe mais dependência com sistema operacional e todo o código é livre. Cabe a cada um fazer sua escolha.

![ASP.NET On Your Terms][14]

Andar em direção a proporcionar um ambiente verdadeiramente “host agnostic” é um passo ambicioso e, nos dias de hoje, cada vez mais necessário. A Microsoft dessa vez acerta em cheio e caminha na direção que a comunidade .NET aponta. 
Esse texto tem como objetivo iniciar o processo de descoberta sobre o vNEXT e as mudanças que ele propõe. Continue e vá mais fundo no conhecimento para criar sua própria opinião acessando os links a seguir:

## REFERÊNCIAS

- [Introducing ASP.NET vNext - Scott Hanselman][6]
- [Channel 9 Live: ASP.NET Developer Q&A with Scott Hunter & Scott Hanselman][7]
- [The Future of .NET in the Server: ASP.NET vNext optimized for Cloud and Server workloads][8]
- [The Future of .NET on the Server (By Scott Hanselman and Scott Hunter) ][9]
- [ASP.NET vNEXT no Github ][10]
- [The Future of .NET on the Server (By Scott Hanselman and David Fowler) (Sessão Avançada)][11]
- [KRuntime no Github][12]

[1]: http://www.asp.net/mvc
[2]: http://www.asp.net/web-pages
[3]: http://www.asp.net/web-api
[4]: http://www.asp.net/mvc
[5]: http://msdn.microsoft.com/en-us/library/yf1d93sz(v=vs.110).aspx
[6]: http://www.hanselman.com/blog/IntroducingASPNETVNext.aspx
[7]: http://channel9.msdn.com/Events/TechEd/NorthAmerica/2014/C9-09
[8]: http://blogs.msdn.com/b/cesardelatorre/archive/2014/05/12/the-future-of-net-in-the-server-asp-net-vnext-optimized-for-cloud-and-server-workloads.aspx
[9]: http://channel9.msdn.com/Events/TechEd/NorthAmerica/2014/DEV-B385
[10]: https://github.com/aspnet/Home/wiki
[11]: http://channel9.msdn.com/Events/TechEd/NorthAmerica/2014/DEV-B411
[12]: https://github.com/aspnet/KRuntime
[13]: /content/img/blog/posts/2014-08-14/aspnet-stack.png 

[14]: /content/img/blog/posts/2014-08-14/aspnet-onyourterms.png 
