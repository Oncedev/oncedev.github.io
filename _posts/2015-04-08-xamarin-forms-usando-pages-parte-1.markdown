---
layout: post
title:  "Xamarin Forms: Usando Pages - Parte 1"
date:   2015-04-08 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

No último post mostrei o esqueleto de uma aplicação Xamarin.Forms e usamos alguns dos componentes da API para criar uma tela simples que possui aparência e usabilidade nativa em cada uma das três plataformas. A partir desse post iremos conhecer mais os componentes da API começando pelas `Pages`.

### Pages

Uma `Page` no Xamarin.Forms representa uma tela dos nossos aplicativos mobile, funcionando assim de forma análoga as `Activities` no Android, as `ViewControllers` no iOS e as homôminas `Pages` do Windows Phone. A figura abaixo mostra todos os tipos de Pages que fazem parte do Xamarin.Forms, nesse post falaremos sobre a `ContentPage` e a `NavigationPage`, deixando a `TabbedPage`, a `MasterDetailPage` e a `CarouselPage` para um próximo post.

![Tipos de Pages][1]

#### ContentPage

No Xamarin.Forms cada Page tem o seu conteúdo associado a propriedade `Content` do tipo `View`, tipo esse, que é super classe de todos os Layouts e de todos os Controls da API (Lembra do `StackLayout`, do `Label` e `Entry` que vimos no [último post?][10]). O `ContentPage` é exatamente uma página com uma view dentro dela.

![ContentPage com Lorem Ipsun][2]

A figura acima mostra uma `ContentPage` onde a propriedade `Content` foi preenchida com um Label contendo um Lorem Ipsum aleatório conforme o código abaixo.

{% highlight c# %}
public class FirstPage : ContentPage
{
	public FirstPage ()
	{
		Content = new Label {
			XAlign = TextAlignment.Center,
			Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
			"Nulla finibus, quam in elementum mattis, ipsum velit bibendum nisi, " +
			"ut feugiat ligula mi at lectus. Cras pretium elit a tortor accumsan " +
			"sagittis. Nunc vulputate libero sed sapien fermentum, eget condimentum " +
			"elit volutpat. Phasellus tincidunt sem mattis maximus auctor. Nunc congue " +
			"sodales urna, vel venenatis tortor tristique at. Vestibulum volutpat " +
			"sollicitudin mi vitae viverra. Nunc sollicitudin, nisl ac placerat congue, " +
			"erat libero fringilla ante, at sodales risus leo ut lorem."
		};
	}
}
{% endhighlight %}

Como falei anteriormente nós também podemos usar Layouts como conteúdo de uma `ContentPage`, a imagem abaixo mostra uma `ContentPage` onde um `StackLayout` foi usado para mostrar as cores do arco-íris.

![ContentPage com as cores do arco-íris][3]

E o código abaixo é o código utilizado para criar a ContentPage com o arco-íris.

{% highlight c# %}
public class RainbowPage : ContentPage
{
	public RainbowPage ()
	{
		Content = new StackLayout () {				
			Children = {
				new BoxView() {Color = Color.Red},
				new BoxView() {Color = Color.FromRgb(255, 102, 0)},
				new BoxView() {Color = Color.Yellow},
				new BoxView() {Color = Color.Green},
				new BoxView() {Color = Color.Blue},
				new BoxView() {Color = Color.FromRgb(111, 0, 255)},
				new BoxView() {Color = Color.FromRgb(159, 0, 255)}
			}	
		};
	}
}
{% endhighlight %}

#### NavigationPage

A `NavigationPage` serve para gerenciar uma pilha navegável de páginas e também é a forma mais utilizada para fazer navegação entre páginas em aplicações mobile (com certeza você já utilizou várias vezes esse tipo de navegação). Uma NavigationPage vai adicionar ao cabeçalho uma barra de navegação que mostrará o título da página atual e um botão de Voltar. 

Ao criar uma NavigationPage é necessário informar uma page em seu construtor que será o primeiro elemento da pilha de páginas (raiz). Como toda pilha, nós vamos interagir com ela empilhando e desempilhando novas páginas (*First-In First Out*). As Pages do Xamarin.Forms implementam a interface `INavigation` (box abaixo) que fornece os métodos para necessários para essa interação.

{% highlight c# %}
public interface INavigation
{
    Task PushAsync(Page page);
    Task<Page> PopAsync();
    Task PopToRootAsync();
    Task PushModalAsync(Page page);
    Task<Page> PopModalAsync();
}
{% endhighlight %}

No próximo exemplo criaremos quatro páginas, uma NavigationPage, que gerenciará a navegação, duas ContentPage, uma vermelha e uma azul que terão botões que irão interagir com a pilha de navegação (poderemos empilhar uma página vermelha, empilhar uma página azul e voltar para a página raiz) e um label que mostrará o estado atual da pilha e a `ColorPage` que concentrará código comum à ambas `ContentPages`, afinal, nós gostamos de Xamarin mas também gostamos de boas práticas né?! Vamos na ordem:

{% highlight c# %}
// Nav Page
public class NavPage : NavigationPage
{
	public NavPage () : base(new BluePage())
	{			
	}
}
{% endhighlight %}

O código da `NavPage` é bem simples, ela apenas cria uma página de navegação e associa uma `BluePage` como primeiro elemento da pilha de navegação.

{% highlight c# %}
// Blue Page
public class BluePage : ColorPage
{		
	public BluePage () : base()
	{			
		BackgroundColor = Color.Blue;
		Title = "Blue Page";
	}
}

// Red Page
public class RedPage : ColorPage
{
	public RedPage () : base()
	{			
		BackgroundColor = Color.Red;
		Title = "Red Page";
	}
}

{% endhighlight %}

Tanto a `RedPage` quanto a `BluePage` instanciam as suas propriedades de `BackgroundColor`, que será exibido em toda a tela do celular (exceto na barra de navegação) e de `Title`, que será exibido no cabeçalho da barra de navegação e ao lado do botão de Voltar conforme formos navegando entre as páginas. Note que ambas herdam de `ColorPage` já que, como ambas tem o mesmo visual e comportamento, não faz sentido repetir esse código em ambas as classes.


{% highlight c# %}
// Color Page
public abstract class ColorPage : ContentPage
{
	private StackLayout _pages;

	public ColorPage ()
	{
		_pages = new StackLayout ();

		// Create Buttons
		var redButton = new Button () {Text = "Push Red Page"};
		redButton.Clicked += async (object sender, EventArgs e) => 
		{
			await this.Navigation.PushAsync(new RedPage());
		};

		var blueButton = new Button () {Text = "Push Blue Page"};
		blueButton.Clicked += async (object sender, EventArgs e) => 
		{
			await this.Navigation.PushAsync(new BluePage());
		};

		var backButton = new Button () {Text = "Back"};
		backButton.Clicked += async (object sender, EventArgs e) => 
		{
			await this.Navigation.PopAsync();
		};

		var rootButton = new Button () {Text = "Back to Root"};
		rootButton.Clicked += async (object sender, EventArgs e) => 
		{
			await this.Navigation.PopToRootAsync();
		};

		// Create Content
		Content = new StackLayout () 
		{
			Children = {
				redButton,
				blueButton,
				backButton,
				rootButton,
				_pages
			}	
		};
	}
		
	protected override void OnAppearing ()
	{
		// Override default OnAppearing and write NavigationStackContent
		_pages.Children.Clear ();
		foreach (var page in this.Navigation.NavigationStack) {
			_pages.Children.Add (
				new Label () 
				{
					Text = page.GetType().ToString()
				}
			);
		}
	}
}

{% endhighlight %}

O código da `ColorPage` acaba sendo o mais complicado do exemplo, mas não é difícil de entender, no construtor da página, nós construímos os elementos visuais da página (botões e listagem de páginas) e atribuímos os seus respectivos eventos de navegação usando os métodos *PushAsync* para inserir uma nova página na pilha, o método *PopAsync* para desempilhar apenas uma página e o método *PopToRootAsync* para desempilhar todas as páginas até que reste apenas a primeira página na pilha.

Nesse exemplo também iremos usar pela primeira vez nesse blog o método *OnAppearing*, o *OnAppearing* faz parte do ciclo de eventos de inicialização da página, nesse caso, podemos sobreescrever esses métodos para realizar alguma operação, no caso, estou utilizando para obter as páginas da pilha e inserir elas no StackLayout. Mas por quê não fazer isso no construtor? O que acontece é que no construtor a página ainda não pertence a pilha de navegação e portanto não temos acesso a `NavigationStack`.

Ao navegarmos pelo aplicativo teremos as telas abaixo:

Tela Inicial

![Primeira Página][4]

Após clicarmos no botão *Push Red Page*, nós agora estamos na `RedPage` e a nossa pilha de navegação tem agora 2 páginas.

![Segunda Página][5]

Ao clicarmos no botão de *Back*, a `RedPage` será desempilhada e voltaremos ao estado inicial da pilha.

![Terceira Página][6]

Ao clicarmos 3 vezes no botão de *Push Red Page*, nós agora estamos na `RedPage` e a nossa pilha de navegação tem agora 4 páginas.

![Quarta Página][7]

Ao clicarmos no botão *Back to Root*, todas as telas exceto a primeira serão desempilhadas e voltaremos ao estado incial da pilha.

![Quinta Página][8]

### Era isso!

O objetivo do post era mostrar as páginas mais usadas quando estamos desenvolvendo um aplicativo usando o Xamarin.Forms, ficou um pouco longo mas espero que vocês tenham gostado [(lembrando que todos os exemplos estão disponibilizados no meu github).][9] Nos próximos post vamos dar uma olhada nas Pages restantes (`TabbedPage`, `MasterDetailPage` e na `CarouselPage`), qualquer dúvida podem perguntar nos comentários ou me procurar nas redes sociais. Até mais!

[1]: /content/img/blog/posts/2015-04-08/pages.png
[2]: /content/img/blog/posts/2015-04-08/loren-ipsum.png
[3]: /content/img/blog/posts/2015-04-08/rainbow.png
[4]: /content/img/blog/posts/2015-04-08/first-page.png
[5]: /content/img/blog/posts/2015-04-08/second-page.png
[6]: /content/img/blog/posts/2015-04-08/third-page.png
[7]: /content/img/blog/posts/2015-04-08/forth-page.png
[8]: /content/img/blog/posts/2015-04-08/fifth-page.png
[9]: https://github.com/pauloortins/MyXamarinSamples
[10]: /mobile/2015/03/18/anatomia-de-um-aplicativo-xamarins-forms/ 
