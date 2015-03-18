---
layout: post
title:  "O que é o Xamarin.Forms e pra que serve?"
date:   2015-03-08 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Olá pessoal, tudo bom? Aqui estou mais uma vez para falar de Xamarin, nesse post vou falar sobre o Xamarin.Forms, uma API lançada em 2014 e que nos possibilita compartilhar ainda mais código entre os nossos aplicativos mobile.

### Xamarin o que?

Se você não sabe muito bem o que é o Xamarin, ou nunca ouviu falar, há alguns meses atrás eu escrevi um post nesse mesmo blog explicando tudinho e [você pode conferir nesse link][3]. A verdade é que a plataforma vem evoluindo a passos largos e a cada ano, nós, desenvolvedores de aplicativos, somos presenteados por Miguel de Icaza, Nat Friedman e sua trupe com novas soluções para os nossos maiores problemas. 

O [Xamarin.Forms][4] foi um desses grandes presentes, como vimos no outro post, o Xamarin nos permite criar aplicativos híbridos utilizando o C# e compartilhando boa parte do nosso código, esse código compartilhado é justamente o código responsável pelas partes comuns às 3 plataformas, como por exemplo, regras de negócio e acesso a webservices e bancos de dados locais. 

No entanto, uma parte do código não era compartilhada, ou seja, deveria ser escrita para cada plataforma, é a interface do usuário e é justamente esse fato que diferencia o Xamarin de outras soluções híbridas, escrevendo uma UI para cada plataforma, nós conseguimos garantir que o nosso usuário vai ter a melhor experiência de uso possível e exatamente igual ao que ele já está acostumado em outros aplicativos ou funcionalidades do sistema operacional do seu aparelho. Logo, para colocar um texto na tela usando o Xamarin tradicional é necessário criar um `UILabel` no iOS, um `TextView` no Android e `TextBlock` no Windows Phone. 

Mas pera aí, se nós já sabemos quais são as classes que deveremos instanciar para cada plataforma e seus respectivos atributos e métodos e todos eles já são escritos em C# por que não criar uma abstração em cima dessas APIs e reaproveitar ainda mais código? Por exemplo, para colocar um texto na tela eu poderia simplesmente instanciar um `Label` e o próprio Xamarin se encarregaria de instanciar a classe correta para cada plataforma, para criar um campo de texto, eu poderia simplesmente instanciar um `Entry` ou quem sabe em um sonho distante instanciar uma `TabbedPage` e o Xamarin por si só criar abas exatamente iguais às abas utilizadas em cada plataforma. Mas posso te falar uma coisa? Isso não é um sonho e nem está distante é justamente o **Xamarin.Forms**, uma api que encapsula as APIs nativas de cada sistema operacional e que nos permite, dessa forma, compartilhar ainda mais código em nossas aplicações Xamarin.

### Xamarin.Forms, um único app, três diferentes experiências

Dê uma olhada no código abaixo, ele usa a API do Xamarin.Forms para criar uma tela com duas abas, onde uma das abas é a implementação de uma tela de login, nesse exemplo já começamos a conhecer algumas das classes do Forms, como a `TabbedPage`, usada para criar telas com abas, a `ContentPage`, usada para criar páginas com contéudo, a `Entry`, que serve para criar campos de texto e a classe `Button`, que serve para criar botões.

{% highlight c# %}
using Xamarin.Forms;

var profilePage = new ContentPage {
    Title = "Profile",
    Icon = "Profile.png",
    Content = new StackLayout {
        Spacing = 20, Padding = 50,
        VerticalOptions = LayoutOptions.Center,
        Children = {
            new Entry { Placeholder = "Username" },
            new Entry { Placeholder = "Password", IsPassword = true },
            new Button {
                Text = "Login",
                TextColor = Color.White,
                BackgroundColor = Color.FromHex("77D065") }}}
};

var settingsPage = new ContentPage {
    Title = "Settings",
    Icon = "Settings.png",
    (...)
};

var mainPage = new TabbedPage { Children = { profilePage, settingsPage } };
{% endhighlight %}

Quando executamos o código acima é que mágica acontece e podemos observar os 3 aplicativos gerados na imagem abaixo, **o mais importante aqui é observar a fidelidade que as telas possuem em relação a cada sistema operacional, podemos perceber isso na disposição das abas e no formato dos botões e dos campos de texto.**

![Aplicações Xamarin.Forms][1]


### Existem muitos mais componentes a nossa disposição

Os componentes citados no exemplo são alguns dos vários componentes que temos a nossa disposição, a imagem abaixo ilustra isso. Os componentes da API são divididos em três categorias, **Pages**, são as páginas propriamente ditas e a `TabbedPage` e a `ContentPage` se encaixam nessa categoria, os **Layouts**, que são possibilidades de organização de componentes, o `StackLayout` se encaixa nessa categoria, e os **Controls**, que são os controles que o usuário vai interagir, o `Entry` e `Button` fazem parte desse último grupo.

![Pages, Layouts e Controles][2]

### Acesso a APIs e Elementos Nativos

E não é só isso, embora o Xamarin.Forms encapsule as APIs nativas de cada plataforma, ainda assim é possível acessá-las caso seja necessária alguma implementação específica para cada plataforma, como por exemplo, as APIs de voz e o acesso a arquivos. Essas implementações específicas são feitas de duas formas: usando **Custom Renderers** e usando **DependencyService**.

### Até breve!

Eu não poderia estar mais empolgado com o Xamarin.Forms, a API está em constante atualização e na OnceDev, para a felicidade dos nossos clientes, já vem se mostrando um excelente diferencial competitivo nos possibilitando entregar **ótimos aplicativos nas 3 principais plataformas e com um custo bem reduzido.**
 
Nos próximos posts irei falar sobre cada uma das características do Xamarin.Forms, mas, caso você não queira esperar, coloquei ao final do post alguns links bem interessantes. Um grande abraço!

#### Links Interessantes

- [Página para o tutorial da própria Xamarin][6]
- [Livro Creating Mobile Apps with Xamarin.Forms, atualmente em preview][7]
- [Xamarin.Forms Kickstarter, web book sobre Xamarin.Forms em constante atualização][5]
- [Palestra - Your First Xamarin.Forms App por Craig Dunn][8]

[1]: /content/img/blog/posts/2015-03-07/example-forms.png
[2]: /content/img/blog/posts/2015-03-07/forms-controls.png
[3]: /mobile/2015/03/08/xamarin-forms/
[4]: http://xamarin.com/forms
[5]: http://www.xforms-kickstarter.com/
[6]: http://developer.xamarin.com/guides/cross-platform/xamarin-forms/introduction-to-xamarin-forms/
[7]: http://www.amazon.com/gp/product/B00NXYJ8DK/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00NXYJ8DK&linkCode=as2&tag=paulorti-20&linkId=7445BJ7K7EJKNLXU
[8]: https://www.youtube.com/watch?v=xWyOcEpNyXQ
