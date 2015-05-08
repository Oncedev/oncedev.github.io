---
layout: post
title:  "Xamarin Forms: Usando Pages - Parte 3"
date:   2015-05-08 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Esse post fecha a seção sobre Pages aqui no blog, nesse último post mostrarei a MasterDetailPage, exemplos de aplicativos que a utilizam e como é de praxe, um aplicação prática desse tipo de Page. 

### MasterDetailPage

Como o próprio nome evidencia, a `MasterDetailPage` serve para mostrar uma dupla de páginas onde uma das páginas é a página `Master`, que vai funcionar como navegação e outra página é a página de `Detail` que vai detalhar as informações selecionadas na página master.

### MasterDetailPage no Smartphone

Nos smartphones, pelo seu tamanho reduzido, não conseguimos mostrar a página `Master` e a página `Detail` ao mesmo tempo, nesse caso, por padrão é exibida a página `Detail` e ao arrastar a página lateralmente do canto esquerdo para o canto direito ou ao clicar no botão da barra de navegação a página Master é deslizada por cima da página de Detail, dessa forma, toda a página `Master` é exibida enquanto a página `Detail` fica parcialmente escondida.

O exemplo mais recente para aqueles que acompanham as notícias do [Xamarin][12] é o app da [Xamarin Evolve 2014][13], nesse app a pagina `Master` atua como menu onde temos os seguintes itens: Sessions, Speakers, Favorites, Places, About e Sponsors, ao selecionar qualquer um desses, a página master se retrai e temos acesso ao conteúdo relativo ao item de menu escolhido na página `Detail`.

![Aplicativo Xamarin Evolve][2]

### MasterDetailPage no Tablet

Nos tablets, por termos mais espaço em tela, é possível mostrar ambas as páginas lado a lado e um exemplo clássico de uso desse tipo são os aplicativos de email, onde na página `Master` nós temos as informações básicas dos emails e, ao selecionar um desses emails, ele é exibido por completo na página `Detail` para podermos lê-lo.

![Aplicativo Gmail][1]

### Places App

Nesse post vou demonstrar a `MasterDetailPage` através da criação de um aplicativo chamado `Places`, o Places vai ser um aplicativo que listará lugares de acordo com três possíveis categorias: Comida (Food), Compras (Shopping) e Esportes (Sports).

Para a construção do Places, vamos usar uma MasterDetailPage, onde a página `Master` vai possuir um menu com as três possíveis categorias e, ao selecionarmos uma dessas categorias, exibiremos o nome, o endereço e uma foto dos lugares relacionados a ela na página de `Detail`.

Então nossa solução fica assim:
Uma `MasterDetailPage` onde a página `Master` vai ser uma [ContentPage][14] com uma [ListView][15] que listará as categorias e a página `Detail` vai ser sempre umas das três [ContentPages][14] que representarão cada uma das categorias e usarão uma [ListView][15] para listar as informações dos lugares.

### Construindo a página Master: Menu

Como foi discutido acima a página de Menu será uma [ContentPage][14] com uma [ListView][15] que listará as categorias, onde cada categoria dessa estará relacionada a uma outra [ContentPage][14], então vamos começar criando a classe `Category`.

A classe `Category` terá um nome e uma função que retornará a [ContentPage][14] que ela está associada.

{% highlight c# %} 
public class Category
{
	public string Name {
		get;
		set;
	}

	public Func<ContentPage> PageFn {
		get;
		set;
	}

	public Category (string name, Func<ContentPage> pageFn)
	{
		Name = name;
		PageFn = pageFn;
	}
}
{% endhighlight %}

Pronto! Agora, para a construção do Menu usaremos uma [ListView][15] que listará objetos do tipo `Category` usando o template `TextCell` (um dos templates de célula default do Xamarin). Além disso também são informados o `Title` da página (obrigatória em uma página Master) e o `Icon` que vai ser exibido na barra de navegação.

O código de criação da `MenuPage` é bem simples:

{% highlight c# %}
public class MenuPage : ContentPage
{
	public MenuPage ()
	{
		Title = "Menu";
		Icon = "menu.png";

		Padding = new Thickness (10, 20);

		var categories = new List<Category> () {
			new Category("Food", () => new FoodCategoryPage()),
			new Category("Shopping", () => new ShoppingCategoryPage()),
			new Category("Sports", () => new SportsCategoryPage())
		};

		var dataTemplate = new DataTemplate (typeof(TextCell));
		dataTemplate.SetBinding (TextCell.TextProperty, "Name");

		var listView = new ListView () {
			ItemsSource = categories,
			ItemTemplate = dataTemplate
		};

		Content = listView;
	}
}
{% endhighlight %}

### Criando a MasterDetailPage

O próximo passo é criar de fato a `MasterDetailPage`, a MasterDetailPage possui as propriedades `Master` e `Detail` do tipo `Page` que representam as páginas que a gente já vem discutindo nesse post.

Vamos criar uma página chamada `MasterDetail` que herda de `MasterDetailPage` e como, até agora, nós só temos a `MenuPage` criada, vamos associa-la a propriedade `Master` e preencher a propriedade `Detail` com uma página vazia.

O código por enquanto fica assim:

{% highlight c# %}
public class MasterDetail : MasterDetailPage
{
	public MasterDetail ()
	{
		Master = new MenuPage ();

		// Por enquanto vazia
		Detail = new NavigationPage(new ContentPage ());
	}
}
{% endhighlight %}

Ao executar o código abaixo no smartphone nós temos as seguintes telas:

![MasterDetailPage com tela de Master][3]

### Criando as Categorias

![Página de Comida][4]

As nossas listas de lugares devem ficar iguais as telas acima, para isso, vamos usar uma [ListView][15] que listará objetos do tipo `Place` e usaremos um template para garantirmos que os objetos vão ser renderizados da forma que queremos.

A classe `Place` possuirá três propriedades, `Name` (Nome), `Icon` (Ícone) e `Address` (Endereço), conforme o código abaixo.

{% highlight c# %}
public class Place
{
	public string Name {
		get;
		set;
	}

	public string Icon {
		get;
		set;
	}

	public string Address {
		get;
		set;
	}

	public Place (string name, string icon, string address)
	{
		Name = name;
		Icon = icon;
		Address = address;
	}
}
{% endhighlight %}

Para essa listagem usaremos o template `ImageCell`, outro template que já vem por default na API do Xamarin.Forms. O `ImageCell` é um template composto de três componentes: ícone, texto e detalhe do texto. Consegue notar que ele casa exatamente com a nossa necessidade?

Na configuração do template, vamos associar a propriedade `Name` da classe `Place` ao texto do `ImageCell`, a `Icon` ao ícone e a `Address` ao detalhe do texto.

{% highlight c# %}
var imageTemplate = new DataTemplate (typeof(ImageCell));
imageTemplate.SetBinding (ImageCell.TextProperty, "Name");
imageTemplate.SetBinding (ImageCell.ImageSourceProperty, "Icon");
imageTemplate.SetBinding (ImageCell.DetailProperty, "Address");
{% endhighlight %}

O resto do código é bem simples e se repete para cada categoria.

{% highlight c# %}
public class FoodCategoryPage : ContentPage
{
	public FoodCategoryPage ()
	{
		Title = "Food";

		Padding = new Thickness (10, 20);

		var places = new List<Place> () 
		{
			new Place("McDonalds", "mcdonalds.png", "1010 S McKenzie St Foley, AL"),
			new Place("Burger King", "burgerKing.png", "910 S McKenzie St Foley AL"),
			new Place("Apple Bees", "appleBees.png", "2409 S McKenzie St, Foley, AL"),
			new Place("Taco Bell", "tacoBell.jpg", "1165 S McKenzie St, Foley, AL"),
			new Place("Subway", "subway.jpg", "610 S McKenzie St Foley, AL")
		};

		var imageTemplate = new DataTemplate (typeof(ImageCell));
		imageTemplate.SetBinding (ImageCell.TextProperty, "Name");
		imageTemplate.SetBinding (ImageCell.ImageSourceProperty, "Icon");
		imageTemplate.SetBinding (ImageCell.DetailProperty, "Address");

		var listView = new ListView () 
		{
			ItemsSource = places,
			ItemTemplate = imageTemplate
		};

		Content = listView;
	}
}

public class ShoppingCategoryPage : ContentPage
{
	public ShoppingCategoryPage ()
	{
		Title = "Shopping";

		Padding = new Thickness (10, 20);

		var places = new List<Place> () 
		{
			new Place("Walmart", "walmart.jpeg", "2200 S McKenzie St, Foley"),
			new Place("Tanger Outlet Center", "tanger.jpg", "2601 S McKenzie St, Ste 466, Foley, AL"),
			new Place("Radio Shack", "radioShack.jpg", "1190 S Mckensie, Foley, AL")
		};

		var imageTemplate = new DataTemplate (typeof(ImageCell));
		imageTemplate.SetBinding (ImageCell.TextProperty, "Name");
		imageTemplate.SetBinding (ImageCell.ImageSourceProperty, "Icon");
		imageTemplate.SetBinding (ImageCell.DetailProperty, "Address");

		var listView = new ListView () 
		{
			ItemsSource = places,
			ItemTemplate = imageTemplate
		};

		Content = listView;
	}
}

public class SportsCategoryPage : ContentPage
{
	public SportsCategoryPage ()
	{
		Title = "Sports";

		Padding = new Thickness (10, 20);

		var places = new List<Place> () 
		{
			new Place("The Gulf Bowl", "gulfBowl.jpg", "2881 S Juniper St, Foley, AL"),
			new Place("Foley Sports Complex", "foleySportsComplex.jpg", "998 W Section Ave, Foley, AL"),
			new Place("Swatters Sports Complex", "swattersSportsComplex.jpg", "21431 Co Rd 12 S Foley, AL")
		};

		var imageTemplate = new DataTemplate (typeof(ImageCell));
		imageTemplate.SetBinding (ImageCell.TextProperty, "Name");
		imageTemplate.SetBinding (ImageCell.ImageSourceProperty, "Icon");
		imageTemplate.SetBinding (ImageCell.DetailProperty, "Address");

		var listView = new ListView () 
		{
			ItemsSource = places,
			ItemTemplate = imageTemplate
		};

		Content = listView;
	}
}
{% endhighlight %}

Ao executar o código em um iPhone, nós temos as seguintes telas:

![Categorias iPhone][10]

### Associando as Categorias à página Detail

Para associar as categorias a página `Detail` precisamos fazer algumas modificações no código do aplicativo.

A primeira é escolher uma das páginas como a página default, o aplicativo não pode começar com uma página em branco, então vamos escolher a `FoodCategoryPage` como página de `Detail` default do app.

{% highlight c# %}
public class MasterDetail : MasterDetailPage
{
    public MasterDetail ()
    {
	    Master = new MenuPage ();
	    Detail = new NavigationPage(new FoodCategoryPage ());
    }
}
{% endhighlight %}

A segunda modificação é alterar o código da `MenuPage` para que, ao selecionar uma categoria na [ListView][15], a página de Detail seja alterada para mostrar os lugares da categoria selecionada. Para isso vamos usar o evento `ItemSelected` da [ListView][15] que por sua vez chamará uma `Action` que será configurada pela classe que instanciar a `MenuPage`.

O código da `MenuPage` fica assim:

{% highlight c# %}
public class MenuPage : ContentPage
{
	public Action<ContentPage> OnMenuSelect {
		get;
		set;
	}

	public MenuPage ()
	{
		Title = "Menu";
		Icon = "menu.png";

		Padding = new Thickness (10, 20);

		var categories = new List<Category> () {
			new Category("Food", () => new FoodCategoryPage()),
			new Category("Shopping", () => new ShoppingCategoryPage()),
			new Category("Sports", () => new SportsCategoryPage())
		};

		var dataTemplate = new DataTemplate (typeof(TextCell));
		dataTemplate.SetBinding (TextCell.TextProperty, "Name");

		var listView = new ListView () {
			ItemsSource = categories,
			ItemTemplate = dataTemplate
		};

		listView.ItemSelected += (object sender, SelectedItemChangedEventArgs e) => {
			if (OnMenuSelect != null)
			{
				var category = (Category) e.SelectedItem;
				var categoryPage = category.PageFn();
				OnMenuSelect(categoryPage);
			}				
		};


		Content = listView;
	}
}
{% endhighlight %}

A página `MasterDetail` tem que agora configurar a `MenuPage` para que, quando uma categoria for selecionada, primeiro, uma nova página de `Detail` seja configurada e segundo, fazermos o dismiss da página `Master`.

{% highlight c# %}
menuPage.OnMenuSelect = (categoryPage) => {
	Detail = new NavigationPage(categoryPage);
	IsPresented = false;
};
{% endhighlight %}

O código final da `MasterDetail` fica assim:

{% highlight c# %}
public class MasterDetail : MasterDetailPage
{
	public MasterDetail ()
	{
		var menuPage = new MenuPage ();
		menuPage.OnMenuSelect = (categoryPage) => {
			Detail = new NavigationPage(categoryPage);
			IsPresented = false;
		};

		Master = menuPage;

		Detail = new NavigationPage(new FoodCategoryPage ());
	}
}
{% endhighlight %}

### Tablets: Telas maiores, mais possibilidades
Nos tablets nós temos mais espaço de tela e por isso abrem-se diferentes possibilidades para o uso da `MasterDetailPage`, usando o enum `MasterBehavior` nós podemos configurar qual vai ser o comportamento da página `Master`.

{% highlight c# %}
namespace Xamarin.Forms
{
	public enum MasterBehavior
	{
		Default,
		SplitOnLandscape,
		Split,
		Popover,
		SplitOnPortrait
	}
}
{% endhighlight %}

{% highlight c# %}
MasterBehavior = MasterBehavior.Default;
{% endhighlight %}

Usando o `MasterBehavior.Default`, no portrait a página Master fica oculta enquanto no landscape ela sempre aparece visível.

![MasterBehavior.Default][5]

Usando o `MasterBehavior.Popover`, a página Master sempre fica oculta, independente da posição.

![MasterBehavior.Popover][6]

Usando o `MasterBehavior.Split`, a página Master sempre fica visível, independente da posição.

![MasterBehavior.Split][7]

Usando o `MasterBehavior.SplitOnLandscape`, a página Master fica visível na posição landscape mas oculta na portrait.

![MasterBehavior.SplitOnLandscape][8]

Usando o `MasterBehavior.SplitOnPortrait`, a página Master fica visível na posição portrait porém oculta na landscape.

![MasterBehavior.SplitOnPortrait][9]

### Era isso!

O post ficou bem completinho sobre o uso da `MasterDetailPage` e com esse post, o post sobre [ContentPage e NavigationPage][14] e o post sobre [TabbedPage e CarouselPage][16] nós fechamos a cobertura de todos os tipos de `Pages` do Xamarin.Forms. A partir do próximo post já vamos começar a falar dos tipos de `Layouts!` Grande abraço e nos vemos por aí!

[O código utilizado nesse post se encontra aqui no github.][11]

[1]: /content/img/blog/posts/2015-05-08/gmail-ipad.jpg 
[2]: /content/img/blog/posts/2015-05-08/xamarin-evolve.png 
[3]: /content/img/blog/posts/2015-05-08/master.png 
[4]: /content/img/blog/posts/2015-05-08/food.png 
[5]: /content/img/blog/posts/2015-05-08/master-behavior-default.png 
[6]: /content/img/blog/posts/2015-05-08/master-behavior-popover.png 
[7]: /content/img/blog/posts/2015-05-08/master-behavior-split.png 
[8]: /content/img/blog/posts/2015-05-08/master-behavior-split-landscape.png 
[9]: /content/img/blog/posts/2015-05-08/master-behavior-split-portrait.png 
[10]: /content/img/blog/posts/2015-05-08/categories.png 
[11]: https://github.com/pauloortins/MyXamarinSamples/tree/master/Places
[12]: http://xamarin.com/
[13]: https://evolve.xamarin.com/
[14]: /mobile/2015/04/08/xamarin-forms-usando-pages-parte-1/
[15]: /mobile/2015/05/03/xamarin-forms-usando-listview/ 
[16]: /mobile/2015/04/10/xamarin-forms-usando-pages-parte-2/

