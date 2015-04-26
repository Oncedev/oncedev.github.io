---
layout: post
title:  "Como o Xamarin se compara com outras plataformas?"
date:   2015-04-25 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Tem curiosidade em saber como é a performance do Xamarin comparada aos aplicativos nativos, Cordova ou outras soluções híbridas? Qual o tamanho final do aplicativo comparado aos outros? Quanto compartilhamento de código pode ser esperado? Nesse post vamos ver uma lista cheia de comparações que respondem essas perguntas e muitas outras.

### Porque todo mundo quer saber
 
Toda vez que faço uma palestra, curso ou converso com alguém sobre o Xamarin perguntas como essas surgem a todo momento, produtividade, performance, experiência do usuário e ferramental são preocupações óbvias que devemos ter ao começar um novo projeto mobile e todo mundo quer saber isso. 

Normalmente essas perguntas são respondidas da seguinte forma: "Cara, eu tenho vários links salvos no meu computador vou te mandar pra você dar uma olhada", o problema é que enviar esses links não só toma tempo e atinge poucas pessoas como também não favorece a troca de conhecimento (várias vezes essas pessoas me enviam outros links que eu não conheço). 

Essa lista busca resolver esses problemas, um link único que podemos compartilhar, facilmente acessado por pessoas de todo o Brasil e atualizado e construído por várias mãos, pois todo link que as pessoas me enviarem eu vou colocando aqui. 

### Uma lista colaborativa e construída por várias mãos

#### Geral

[Choosing the Right Mobile Techonology (Escolhendo a tecnologia mobile certa):][1]
O pessoal da Magento escreveu esse excelente white paper onde eles fazem uma comparação entre 4 possibilidades de desenvolvimento de aplicativos, Nativo, Cordova, Xamarin Clássico e o Xamarin.Forms abordando os seguinte pontos: experiência do usuário, performance, produtividade, maturidade da plataforma, ferramental,compartilhamento de código, tendências e suporte futuro.

#### Performance

[24/08/2014 - Performance comparison between Xamarin.Android+C# vs Dalvik/ART+Java:][6]
Comparação entre o Xamarin.Droid e o Java na Dalvik em três pontos: cálculos aritméticos, coleções e generics e uso de strings. 

[23/12/2014 - Mobile Development Platform Performance (Native, Cordova, Classic Xamarin, Xamarin.Forms) part. 1:][2]
Nesse post Kevin Ford criou aplicações de teste para avaliar tanto o tamanho dos aplicativos gerados como mediu, através de um cronômetro manual, índices relacionados a performance, mais especificamente, tempo de carregamento do aplicativo, carregamento de uma lista de mil registros do Azure Mobile Services e cálculo de números primos. 

Alguns pontos interessantes:

- O tamanho dos aplicativos finais com o Xamarin acaba sendo muito superior aos nativos e ao Cordova pelo menos para aplicações de teste, confesso que estou curioso para ver um comparativo com aplicações de verdades e, por consequência, maiores.

- A performance do Xamarin perto das plataformas nativas foi muito similar inclusive sendo superior em alguns casos. A performance do Cordova é a pior disparada (o que já era esperado).

[04/02/2015 - Mobile Development Platform Performance (Native, Cordova, Classic Xamarin, Xamarin.Forms) part. 2:][3]
Alguns meses depois Kevin Ford fez mais um estudo onde ele avaliou novamente o tamanho dos aplicativos assim como mais alguns itens relativos a performance, dessa vez relacionados a IO. Nesse estudo os itens de performance avaliados foram: o tempo de carregamento da página, inserção de mil registros no SQLite, leitura de mil registros do SQLite, inserção de mil linhas em um arquivo e leitura de mil linhas de um arquivo. 

No geral, os resultados continuaram os mesmo do estudo anterior, o ponto mais interessante pra mim foi a variação das medições das versões Xamarin devido ao uso de diferentes bibliotecas, ao usar uma biblioteca cross-plataforma no Android as medições foram as piores possíveis enquanto usando uma versão específica para o Xamarin.Droid obteve resultados iguais à implementação nativa do Android.

[10/02/2015 - Mobile App Performance part. 1:][4]
Nesse estudo Harry Cheung usa uma aplicação de GPS Tracking para comparar tanto a performance computacional como o uso de memória de soluções híbridas e nativas tanto no iOS como no Android. No iOS foram testadas as soluções J2ObjC, Xamarin, RoboVM, RubyMotion e Swift, enquanto no Adnroid foram testados apenas o Java e o Xamarin. Impressiona como o Xamarin é competetitivo perto das plataformas nativas e ainda sim consegue ser cross-plataforma.

[15/03/2015 - Mobile App Performance part. 2:][5]
Após algumas sugestões e pedidos da comunidade Harry Cheung adicionou novas soluções e novos devices ao seu benchmark se tornando o benchmark de performance mobile até aqui. No iOS foram testadas seguintes soluções: C++, Swift, Xamarin, J2ObjC, RoboVM, Objective-C, Javascript (Mobile Browsers e Titanium) enquanto no Android as seguintes soluções foram testadas: C++, Xamarin, Java, Javascript (Mobile Browsers e Titanium).

Os vencedores do benchmark foram (em ordem), no iOS: C++, Swift e Xamarin e no Android: C++, Xamarin e Java. Com um segundo e um terceiro lugar o Xamarin se coloca aqui como uma excelente alternativa.

#### Compartilhamento de Código e Experiência dos Usuários

Ainda estou buscando artigos que falem sobre compartilhamento de código em aplicativos reais e comparando a experiência dos usuários ao utilizar aplicativos feitos usando cada uma das soluções existentes, aqui seria ótimo rodar um experimento coletando feedbacks dos usuários ao usar diferentes versões de um mesmo aplicativo cada uma delas usando uma das soluções possíveis. 

[1]: http://magenic.com/Portals/0/Magenic-White-Paper-Choosing-the-Right-Mobile-Technology.pdf
[2]: http://windingroadway.blogspot.com.br/2014/12/mobile-development-platform-performance.html
[3]: http://windingroadway.blogspot.com.br/2015/02/mobile-development-platform-performance.html
[4]: https://medium.com/@harrycheung/cross-platform-mobile-performance-testing-d0454f5cd4e9
[5]: https://medium.com/@harrycheung/mobile-app-performance-redux-e512be94f976
[6]: [http://xamarinandroid.blogspot.com.br/2014/08/performance-comparison-between.html]

