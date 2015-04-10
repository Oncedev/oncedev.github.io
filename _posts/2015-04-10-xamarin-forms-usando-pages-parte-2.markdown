---
layout: post
title:  "Xamarin Forms: Usando Pages - Parte 2"
date:   2015-04-10 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Olá pessoal! Nesse post volto para falar de mais duas opções de Pages que são a TabbedPage e a CarouselPage. Vamos ver como podemos usá-las para criar os nossos aplicativos móveis!

### TabbedPage

Além da navegação baseada em pilhas, que podemos atingir usando a [NavigationPage][7], uma outra forma bem comum de navegação em aplicações móveis é a navegação em abas, utilizamos esse tipo de navegação todos os dias quando acessamos as nossas redes sociais, seja no [Facebook][1], no [Twitter][2] ou no [Instagram][3].

![Fotos de Abas rede social][4]
O app Quora possui navegação baseada em abas.

Algo importante quando falamos de abas, é termos a idéia de que cada sistema operacional tem um *look and feel* próprio, por exemplo, no Android, as abas são posicionadas no topo e exibem apenas texto, no iOS, as abas são posicionadas ao final da página e apresentam tanto texto quanto ícones, no Windows Phone, as abas não tem o formato de abas propriamente dito e sim são textos navegáveis. Como sempre falo aqui no blog, respeitar essas características é importante para garantir que os nossos usuários tenham sempre uma experiência de uso fluida e intuitiva. Você pode conferir essa diferença nos screenshots do aplicativo [Quora][11] na imagem acima ou no demo abaixo.

Felizmente, o Xamarin.Forms possui uma `Page` específica para abas e que cuida disso tudo para nós, desenvolvedores, e é a `TabbedPage`. [No post introdutório][5] que fiz sobre o Xamarin.Forms nesse mesmo blog já foi possível ter um primeiro contato com a classe mas é nesse post que vamos aprofundar um pouco esse conhecimento.

![Fotos de Abas no primeiro post][6]

Uma TabbedPage não tem contéudo por si só, na verdade, a gente vai atribuir, como filhas, outras paginas com conteúdo próprio ([lembra da ContentPage?][7]) que vão ser gerenciadas pela `TabbedPage`. É importante não esquecer de atribuir as propriedades `Title` e a `Icon` visto que elas serão usadas para a criação das abas. O código abaixo mostra a criação de uma `TabbedPage` e duas `ContentPage` que serão utilizadas como abas da página principal. Como ícones para as abas, usaremos dois ícones do [Ionic Icons][12] que é uma coleção de ícones bem interessante e que eu recomendo fortemente, por default, no iOS (o único que usa ícones nas abas), as imagens são convertidas para um tom de cinza independentes da sua cor original, para usar imagens deveremos adiciona-las em cada projeto específico(iOS e Android) separadamente.
{% highlight c# %}
// Blue Page
public class BluePage : ContentPage
{
	public BluePage ()
	{
		BackgroundColor = Color.Blue;
		Title = "Blue Page";
		Icon = "heart.png";
	}
}

// Red Page
public class RedPage : ContentPage
{
	public RedPage ()
	{
		BackgroundColor = Color.Red;
		Title = "Red Page";
		Icon = "icecream.png";
	}
}

// TabPage
public class TabPage : TabbedPage
{
	public TabPage ()
	{
		this.Children.Add (new BluePage ());
		this.Children.Add (new RedPage ());
	}
}
{% endhighlight %}

Ao executar o código abaixo no Android e no iOS, iremos ter uma tela com duas abas e com uma aparência nativa em cada um dos dispositivos.

![TabbedPage][8]

Quando trabalhamos com abas frequentemente temos a necessidade de interagir com a aba selecionada ou disparar alguma ação quando a aba selecionada é alterada. Na `TabbedPage` temos a propriedade `CurrentPage`, que pode ser usada para setar ou obter a aba selecionada e o evento `CurrentPageChanged` que é disparado toda vez que uma nova aba é selecionada.

{% highlight c# %}
// Obtém ou seta a aba selecionada
public T CurrentPage {
	get;
	set;
}

// Evento que é disparado quando a aba selecionada é alterada
public event EventHandler CurrentPageChanged

{% endhighlight %}

### CarouselPage

Galerias de imagens, pessoas, restaurantes, discos e assim por diante são bastante comuns em aplicações mobile, nesse tipo de apresentação de dados, é exibida uma página em destaque enquanto a navegação entre as páginas é feita através dos eventos conhecidos como *swipe left* ou *swipe right* que consistem em arrastar lateralmente para a direita, ou para a esquerda, a página do aplicativo. 

![Foto Galeria Exemplo][9]

Para a criação de galerias a `CarouselPage` é a escolha certa. A `CarouselPage` é da mesma categoria da `TabbedPage` ,ambas herdam da mesma classe base, a `MultiPage`, no entanto, enquanto a `TabbedPage` organiza suas páginas filhas em abas, a `CarouselPage` organiza essas pages lado a lado e permite a navegação dessas páginas através dos *swipes* laterais. O código abaixo a criação de uma `CarouselPage` com 4 `ContentPages` de cores diferentes, a inicialização é igual a inicialização da `TabbedPage`, a diferença é como elas lidam com as páginas filhas por debaixo do pano.

{% highlight c# %}
// Blue Page
public class BluePage : ContentPage
{
	public BluePage ()
	{
		BackgroundColor = Color.Blue;
	}
}

// Red Page
public class RedPage : ContentPage
{
	public RedPage ()
	{
		BackgroundColor = Color.Red;
	}
}

// Yellow Page
public class YellowPage : ContentPage
{
	public YellowPage ()
	{
		BackgroundColor = Color.Yellow;
	}
}

// Green Page
public class GreenPage : ContentPage
{
	public GreenPage ()
	{
		BackgroundColor = Color.Green;
	}
}

// CarouselPage
public class MyCarouselPage : CarouselPage
{
	public MyCarouselPage ()
	{
		this.Children.Add (new BluePage ());
		this.Children.Add (new RedPage ());
		this.Children.Add (new YellowPage ());
		this.Children.Add (new GreenPage ());
	}
}
{% endhighlight %}

Ao executarmos o projeto, nós vamos ter a página azul como página inicial, mas vamos ser capazes de navegar entre as páginas arrastando as telas.

![Carousel][10]

Como a `CarouselPage` herda da mesma classe base que a `TabbedPage`, nós também conseguimos acessar a página atual e disparar eventos ao alterar a página atual da mesma forma que fazemos quando usamos uma `TabbedPage`.

{% highlight c# %}
// Obtém ou seta a aba selecionada
public T CurrentPage {
	get;
	set;
}

// Evento que é disparado quando a aba selecionada é alterada
public event EventHandler CurrentPageChanged

{% endhighlight %}

Ambos os exemplos demonstrados estão disponíveis no meu github ([TabbedPage][13] e [CarouselPage][14]).

### Era isso!

Nesse post vimos duas pages que agem como gerenciadoras de outras pages que são a `TabbedPage` e a `CarouselPage` e vimos como pode ser fácil utiliza-las para criar navegações iguais às que já estamos acostumados a usar em outros aplicativos no nosso dia-a-dia. No próximo post vamos fechar a seção de Pages com a última da lista: a `MasterDetailPage`.

[1]: www.facebook.com
[2]: www.twitter.com
[3]: www.instagram.com
[4]: /content/img/blog/posts/2015-04-10/quora.png
[5]: /mobile/2015/03/08/xamarin-forms/
[6]: /content/img/blog/posts/2015-04-10/example-forms.png 
[7]: /mobile/2015/04/08/xamarin-forms-usando-pages-parte-1/
[8]: /content/img/blog/posts/2015-04-10/tabpage.png
[9]: /content/img/blog/posts/2015-04-10/gallery.jpg
[10]: /content/img/blog/posts/2015-04-10/carousel.png
[11]: www.quora.com
[12]: http://ionicons.com/
[13]: https://github.com/pauloortins/MyXamarinSamples/tree/master/TabsPage
[14]: https://github.com/pauloortins/MyXamarinSamples/tree/master/Carousel
