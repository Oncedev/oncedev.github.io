---
layout: post
title:  "Xamarin Forms: Usando a ListView"
date:   2015-05-03 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Nesse post vamos falar da ListView, controle usado para mostrar dados em formato de lista.

### ListView

Quase sempre em nossos nossos aplicativos móveis temos a necessidade de mostrar dados em formato de listas, esses dados podem ser pessoas, mensagens, restaurantes ou qualquer outra coisa. O Xamarin.Forms possui um controle específico para esses casos, que é a `ListView`. 

### Construindo a primeira ListView

Para declarar uma `ListView` não precisamos de nada mais além do `ItemsSource` que são os dados que vão ser exibidos na lista. O código abaixo mostra a criação de uma ListView para exibir uma lista de cidades.

{% highlight c# %}
public class TextListViewPage : ContentPage
{
	public TextListViewPage ()
	{
		var cities = new List<string> () {
			"Miami",
			"San Francisco",
			"Los Angeles",
			"Orlando",
			"Houston",
			"New York City"
		};

		var listView = new ListView () {
			ItemsSource = cities
		};

		Content = listView;
	}
}

{% endhighlight %}

Ao executar o código acima tanto no Android como no iOS nós temos as seguintes telas:

![ListView Simples][1]

### Exibindo objetos complexos

A exibição nas listas não se resume a apenas objetos do tipo string, como a propriedade `ItemsSource` é um `IEnumerable`, nós também podemos passar objetos complexos para uma `ListView`. O exemplo abaixo mostra um exemplo utilizando a classe `City`.

{% highlight c# %}
public class ComplexObjectListViewPage : ContentPage
{
	class City
	{
		public string Name {
			get;
			set;
		}

		public string State {
			get;
			set;
		}
	}

	public ComplexObjectListViewPage ()
	{			
		var cities = new List<City> () {
			new City() {State = "FL", Name = "Miami"},
			new City() {State = "CA", Name = "San Francisco"},
			new City() {State = "CA", Name = "Los Angeles"},
			new City() {State = "FL", Name = "Orlando"},
			new City() {State = "TX", Name = "Houston"},
			new City() {State = "NY", Name = "New York City"},
		};

		var listView = new ListView () {
			ItemsSource = cities
		};

		Content = listView;
	}
}
{% endhighlight %}

Se rodarmos o código acima, vamos ver que o resultado não é o esperado, ao invés de mostrar o nome de cada cidade, a lista está mostrando o nome da classe. Por default, a ListView executa o método `ToString()` de cada um dos objetos e por isso o nome da classe está sendo exibido. 

Para que seja atingido o mesmo resultado de antes precisamos adicionar um `DataTemplate`, que é um template que vai orientar a `ListView` em como renderizar cada item da lista.

![ListView Objetos Complexos][2]

### Usando DataTemplate para renderizar a ListView

O Xamarin já vem com alguns templates pré-construídos:

- [TextCell][7]
- [ImageCell][8]
- [SwitchCell][9]
- [EntryCell][10]

Nesse exemplo vamos usar o `TextCell` para renderizar os nomes das cidades, para isso vamos instanciar um `DataTemplate` do tipo `TextCell` e associar o texto da célula a propriedade `Name` da classe `City`. 

{% highlight c# %}
var dataTemplate = new DataTemplate (typeof(TextCell));
dataTemplate.SetBinding (TextCell.TextProperty, "Name");
{% endhighlight %}

O código final fica assim:

{% highlight c# %}
public class ComplexObjectListViewPage : ContentPage
{
	class City
	{
		public string Name {
			get;
			set;
		}

		public string State {
			get;
			set;
		}
	}

	public ComplexObjectListViewPage ()
	{			
		var cities = new List<City> () {
			new City() {State = "FL", Name = "Miami"},
			new City() {State = "CA", Name = "San Francisco"},
			new City() {State = "CA", Name = "Los Angeles"},
			new City() {State = "FL", Name = "Orlando"},
			new City() {State = "TX", Name = "Houston"},
			new City() {State = "NY", Name = "New York City"},
		};

		var dataTemplate = new DataTemplate (typeof(TextCell));
		dataTemplate.SetBinding (TextCell.TextProperty, "Name");

		var listView = new ListView () {
			ItemsSource = cities,
			ItemTemplate = dataTemplate
		};

		Content = listView;
	}
}
{% endhighlight %}

Agora sim, quando executarmos o código acima vamos ter o resultado que estávamos esperando.

![ListView Objetos Complexos TextCell][3]

### Usando Templates Customizados

Muitas vezes apenas os templates já fornecidos pela [Xamarin][12] não vão ser suficientes para desenvolvermos os nossos apps, nesses casos nós vamos ter que construir os nossos próprios templates. Nesse exemplo vou mostrar como criar um template customizado para mostrar tanto o estado como o nome da cidade.

Para criarmos um template customizado devemos herdar de `ViewCell`, definir como o nosso template será renderizado e como ele usará os dados de cada item da lista, no código abaixo nós criamos um template customizado chamado `CustomCell` e estabelecemos que ele terá 4 `Labels`, onde dois deles vão ser labels fixos (“State:” e “Name:”) enquanto os outros dois vão ser dinâmicos, isso é, exibirão as propriedades `State` e `Name` de cada registro.

{% highlight c# %}
class CustomCell : ViewCell
{
	public CustomCell()
	{
		var stateLabel = new Label () 
		{
			Text = "State:"
		};

		var stateText = new Label ();
		stateText.SetBinding (Label.TextProperty, "State");

		var cityLabel = new Label () 
		{
			Text = "City:"	
		};

		var cityText = new Label ();
		cityText.SetBinding (Label.TextProperty, "Name");

		var view = new StackLayout () {
			Orientation = StackOrientation.Horizontal,
			Children = 
			{
				stateLabel,
				stateText,
				cityLabel,
				cityText
			}
		};

		View = view;
	}
}
{% endhighlight %}

Por fim, associamos o novo template ao item template da lista.

{% highlight c# %}
var dataTemplate = new DataTemplate (typeof(CustomCell));
{% endhighlight %}

Abaixo segue o código completo do exemplo.

{% highlight c# %}
public class CustomCellListViewPage : ContentPage
{
	class CustomCell : ViewCell
	{
		public CustomCell()
		{
			var stateLabel = new Label () 
			{
				Text = "State:"
			};

			var stateText = new Label ();
			stateText.SetBinding (Label.TextProperty, "State");

			var cityLabel = new Label () 
			{
				Text = "City:"	
			};

			var cityText = new Label ();
			cityText.SetBinding (Label.TextProperty, "Name");

			var view = new StackLayout () {
				Orientation = StackOrientation.Horizontal,
				Children = 
				{
					stateLabel,
					stateText,
					cityLabel,
					cityText
				}
			};

			View = view;
		}
	}

	class City
	{
		public string Name {
			get;
			set;
		}

		public string State {
			get;
			set;
		}
	}

	public CustomCellListViewPage ()
	{
		Padding = new Thickness (20);

		var cities = new List<City> () {
			new City() {State = "FL", Name = "Miami"},
			new City() {State = "CA", Name = "San Francisco"},
			new City() {State = "CA", Name = "Los Angeles"},
			new City() {State = "FL", Name = "Orlando"},
			new City() {State = "TX", Name = "Houston"},
			new City() {State = "NY", Name = "New York City"},
		};

		var dataTemplate = new DataTemplate (typeof(CustomCell));

		var listView = new ListView () {
			ItemsSource = cities,
			ItemTemplate = dataTemplate
		};

		Content = listView;
	}
}
{% endhighlight %}

Ao executarmos o código acima vamos ter uma listagem onde serão exibidos o nome da cidade e o estado que ela pertence.

![ListView Template Customizado][4]

### Agrupando listas

A `ListView` também suporta agrupamento de registros em seções e a criação de um índice lateral para navegação rápida. Nesse exemplo vamos continuar com as mesmas cidades mas dessa vez queremos mostrá-las agrupadas por estados.

Para mostrar os dados agrupados, vamos ter que mudar um pouco a forma como criamos a nossa lista de cidades, ao invés de criamos uma única lista com todas as cidades, vamos criar uma lista de estados onde cada um desses estados vai possuir um nome e uma lista de cidades, na prática, vamos ter uma lista de listas. Note que a classe `State`(estado) herda de uma coleção, afinal, ela é uma lista de cidades.

{% highlight c# %}
class State : ObservableCollection<City>
{
	public State(string name)
	{
		Name = name;
	}

	public string Name {
		get;
		set;
	}
}

class City
{
	public string Name {
		get;
		set;
	}
}
{% endhighlight %}

Também temos que mudar a inicialização da `ListView` para dizer que ela agora é agrupada e para isso vamos setar as propriedades `IsGroupingEnabled`, `GroupDisplayBinding` e `GroupShortNameBinding`.

{% highlight c# %}
var listView = new ListView () {
	IsGroupingEnabled = true,
	GroupDisplayBinding = new Binding("Name"),
	GroupShortNameBinding = new Binding("Name"),
	ItemsSource = states,
	ItemTemplate = dataTemplate
};

{% endhighlight %}

A propriedade `IsGroupingEnabled` seta se a lista é agrupada ou não, a propriedade `GroupDisplayBinding` seta qual vai ser o texto que será exibido no cabeçalho de cada seção e, por último, a propriedade `GroupShortNameBinding` seta qual vai ser o texto que vai ser exibido nos índices laterais.

Abaixo segue o código completo do exemplo:

{% highlight c# %}
public class GroupingListViewPage : ContentPage
{		
	class State : ObservableCollection<City>
	{
		public State(string name)
		{
			Name = name;
		}

		public string Name {
			get;
			set;
		}
	}

	class City
	{
		public string Name {
			get;
			set;
		}
	}

	public GroupingListViewPage ()
	{
		Padding = new Thickness (20);

		var states = new List<State> () {
			new State("FL") 
			{
				new City() {Name = "Miami"},
				new City() {Name = "Orlando"},
			},
			new State("CA") 
			{					
				new City() {Name = "Los Angeles"},
				new City() {Name = "San Francisco"},
			},
			new State("TX") 
			{					
				new City() {Name = "Houston"},
				new City() {Name = "Austin"},
			},
			new State("NY") 
			{					
				new City() {Name = "New York City"},
			}
		};

		var dataTemplate = new DataTemplate (typeof(TextCell));
		dataTemplate.SetBinding (TextCell.TextProperty, "Name");

		var listView = new ListView () {
			IsGroupingEnabled = true,
			GroupDisplayBinding = new Binding("Name"),
			GroupShortNameBinding = new Binding("Name"),
			ItemsSource = states,
			ItemTemplate = dataTemplate
		};

		Content = listView;
	}
}
{% endhighlight %}

Ao executar o código acima temos a nossa lista de cidades mas dessa vez agrupadas por estado.

![ListView agrupado por estados][5]

### Customizando o cabeçalho dos agrupamentos

Assim como fazemos com os itens da lista também podemos customizar a renderização dos cabeçalhos de cada agrupamento utilizando um template. Nessa seção vamos customizar a exibição de cada agrupamento para mostrar além do nome do estado, também um ícone que o identifique, para isso vamos criar um template customizado da mesma forma que fizemos para os itens da lista.

Nesse caso, vamos ter um `Label` que corresponderá a propriedade `Name` da classe `State` e uma `Image` cuja propriedade `Source` (caminho da imagem) corresponderá a propriedade `Icon` da classe `State`.

{% highlight c# %}
class StateTemplate : ViewCell
{
	public StateTemplate()
	{
		var text = new Label();
		text.SetBinding(Label.TextProperty, "Name");

		var icon = new Image() {
			WidthRequest = 25,
			HeightRequest = 25
		};
		icon.SetBinding(Image.SourceProperty, "Icon");

		var view = new StackLayout() {
			Orientation = StackOrientation.Horizontal,
			Children = {
				icon,
				text
			}
		};

		Height = 30;
		View = view;
	}
}
{% endhighlight %}

Também temos que alterar a inicialização da lista para setar a propriedade `GroupHeaderTemplate` com o template que nós criamos.

{% highlight c# %}
var listView = new ListView () {
	IsGroupingEnabled = true,
	GroupDisplayBinding = new Binding("Name"),
	GroupShortNameBinding = new Binding("Name"),
	ItemsSource = states,
	ItemTemplate = dataTemplate,
	GroupHeaderTemplate = new DataTemplate(typeof(StateTemplate)),
	HasUnevenRows = true
};
{% endhighlight %}

O código completo do exemplo ficou o seguinte:

{% highlight c# %}
public class GroupingTemplateListViewPage : ContentPage
{		
	class State : ObservableCollection<City>
	{
		public State(string name, string icon)
		{
			Name = name;
			Icon = icon;
		}

		public string Name {
			get;
			set;
		}

		public string Icon {
			get;
			set;
		}
	}

	class StateTemplate : ViewCell
	{
		public StateTemplate()
		{
			var text = new Label();
			text.SetBinding(Label.TextProperty, "Name");

			var icon = new Image() {
				WidthRequest = 25,
				HeightRequest = 25
			};
			icon.SetBinding(Image.SourceProperty, "Icon");

			var view = new StackLayout() {
				Orientation = StackOrientation.Horizontal,
				Children = {
					icon,
					text
				}
			};

			Height = 30;
			View = view;
		}
	}

	class City
	{
		public string Name {
			get;
			set;
		}
	}			

	public GroupingTemplateListViewPage ()
	{
		Padding = new Thickness (20);

		var states = new List<State> () {
			new State("FL", "fl.jpg") 
			{
				new City() {Name = "Miami"},
				new City() {Name = "Orlando"},
			},
			new State("CA", "ca.jpeg") 
			{					
				new City() {Name = "Los Angeles"},
				new City() {Name = "San Francisco"},
			},
			new State("TX", "tx.jpg") 
			{					
				new City() {Name = "Houston"},
				new City() {Name = "Austin"},
			},
			new State("NY", "ny.jpg") 
			{					
				new City() {Name = "New York City"},
			}
		};

		var dataTemplate = new DataTemplate (typeof(TextCell));
		dataTemplate.SetBinding (TextCell.TextProperty, "Name");

		var listView = new ListView () {
			IsGroupingEnabled = true,
			GroupDisplayBinding = new Binding("Name"),
			GroupShortNameBinding = new Binding("Name"),
			ItemsSource = states,
			ItemTemplate = dataTemplate,
			GroupHeaderTemplate = new DataTemplate(typeof(StateTemplate)),
			HasUnevenRows = true
		};

		Content = listView;
	}
}
{% endhighlight %}

Ao executar o código acima, os cabeçalhos dos nossos grupos agora possuem imagem e texto.

![ListView agrupado por estados com cabeçalho customizado][6]

### Usando os eventos da ListView

Por fim, apenas listar registros não é suficiente para boa parte dos aplicativos, nós também temos que ser capazes de interagir com a lista através de eventos, como por exemplo, ao selecionar um item da lista nós poderíamos entrar em uma tela de detalhe e assim por diante. O `ListView` possui dois eventos para nos ajudar nesses cenários, o `ItemTapped` e o `ItemSelected`.

O `ItemTapped` é disparado todas as vezes que nós damos um Tap em um dos itens da lista.

{% highlight c# %}
listView.ItemTapped += (object sender, ItemTappedEventArgs e) => {
	DisplayAlert("ItemTapped", e.Item.ToString(), "Ok");
};
{% endhighlight %}

Enquanto o `ItemSelected` é disparado todas as vezes que o item selecionado é alterado logo esse evento é disparado toda vez que damos um Tap em um item não selecionado como também é disparado quando alteramos o item selecionado via código.

{% highlight c# %}
listView.ItemSelected += (object sender, SelectedItemChangedEventArgs e) => {
	DisplayAlert("ItemSelected", e.SelectedItem.ToString(), "Ok");
};

// Alterações via código também disparam o evento ItemSelected
listView.SelectedItem = object;
{% endhighlight %}

### Por hoje é só!

Esse post ficou bem longo, porém é justificável visto que o controle ListView é bem extenso e possui várias configurações possíveis. Agora você pode mandar ver com as ListViews nos seus aplicativos e qualquer dúvida é só entrar em contato comigo! 

[Todos os exemplo estão disponíveis na minha conta do Github.][11]

Até mais!

[1]: /content/img/blog/posts/2015-05-03/list-view-text.png 
[2]: /content/img/blog/posts/2015-05-03/complex-object-text.png 
[3]: /content/img/blog/posts/2015-05-03/complex-object-template.png 
[4]: /content/img/blog/posts/2015-05-03/custom-template.png 
[5]: /content/img/blog/posts/2015-05-03/grouping-list.png 
[6]: /content/img/blog/posts/2015-05-03/grouping-template.png 
[7]: http://iosapi.xamarin.com/index.aspx?link=T%3AXamarin.Forms.TextCell
[8]: http://iosapi.xamarin.com/?link=T%3aXamarin.Forms.ImageCell
[9]: http://iosapi.xamarin.com/?link=T%3aXamarin.Forms.SwitchCell
[10]: http://iosapi.xamarin.com/?link=T%3aXamarin.Forms.EntryCell
[11]: https://github.com/pauloortins/MyXamarinSamples  
[12]: www.xamarin.com

