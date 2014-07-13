---
layout: post
title:  "Criando um mapa da copa do mundo usando o Xamarin.iOS"
date:   2014-07-13 14:17:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile 
---

Em tempo de copa no Brasil é impossível programar sem ao menos dividir a atenção entre o monitor do computador e a peleja rolando na TV. Mas não são só os jogos da copa que tem me empolgado nessas semanas, a capacidade de usar uma única linguagem para programar o servidor e aplicações mobile NATIVAS tem me empolgado bastante e a experiência tem sido bastante interessante. Mas por que não juntar as duas paixões e fazer um post demonstrando um dos recursos do Xamarin para visualizar informações sobre a copa do mundo?

Nesse post pretendo mostrar um passo a passo em como podemos utilizar mapas no Xamarin.iOS e usa-lo para plotar informações sobre as seleções e os estádios da copa do mundo. Iremos seguir usando baby steps na seguinte sequência:

1. Criação de uma aplicação no Xamarin
2. Criação do mapa
3. Plotando pontos no mapa
4. Customizando a aparência dos pontos no mapa

<br/>

## Criação de uma aplicação no Xamarin

O primeiro passo que iremos dar é criar uma aplicação no Xamarin chamada WorldCupMap. Para isso acesse File > New > Solution e crie um novo projeto conforme as configurações da imagem abaixo.

![Criando aplicacao][1]

### Analisando a estrutura do projeto

Após a criação do projeto, o Xamarin automaticamente cria uma estrutura com alguns arquivos. Vamos falar sobre a importância de alguns deles.

![Estrutura do Projeto][2]

O `AppDelegate.cs` tem uma função similar ao global.asax que utilizamos nas aplicações ASP.NET, ele é o responsável por escutar e responder aos eventos da aplicação. Exemplo de eventos que podem ser escutados são DidEnterBackground(disparado quando a aplicação passar a rodar no background) e WillEnterForeground(disparado quando a aplicação está próxima de ficar ativa).

O `Entitlements.plist` guarda informações sobre o uso de alguns serviços da apple, como o iCloud e o PassBook.

O `info.plist` é o principal arquivo de configuração de uma aplicação iOS é nele que configuramos o nome e o identificador da aplicação, os devices que a aplicação suportará (iphone/ipod/ipad/universal), as orientações, íconização e serviços que a aplicação poderá rodar em background como o Maps e Audio.

O `MainStoryboard.storyboard` é a representação visual das telas e do fluxo da nossa aplicação, a manipulação desses arquivos lembra muito o tradicional drag and drop utilizando no WindowsForms/WebForms. Nesses arquivos podemos montar as telas da aplicação iOS fazendo o uso de controles como por exemplo labels, textfields, tables e etc.

O `WorldCupMapViewController.cs` é o arquivo que controla as interações dos controles da view com o modelo da nossa aplicação. É nesse arquivo que vão estar os eventos de clicks, initialização e encerramento.

#### Se tudo estiver certo...

Se tudo estiver certo, ao rodar a aplicação iremos ver uma "bela" tela em branco.

## Criando o mapa

O uso de mapas, hoje em dia, é uma feature comum nas aplicações encontradas na AppleStore e isso não é a toa, o MapKit (framework responsável pelo uso de mapas) possibilita que mapas sejam facilmente adicionados. Para adicionar o mapa em nossa aplicação usaremos poucas linhas.

Vamos abrir a classe `WorldCupMapViewController.cs`, remover todo o seu contéudo e adicionar o código abaixo.

{% highlight c# %}
public partial class WorldCupMapViewController : UIViewController
{
	protected MKMapView map;
	public WorldCupMapViewController (IntPtr handle) : base (handle)
	{
	}

	public override void LoadView ()
	{
		map = new MKMapView (UIScreen.MainScreen.Bounds);
		View = map;
	}
}
{% endhighlight %}

### Executando o projeto

Ao executar o projeto já teremos disponível um mapa com suporte a todos os eventos como o panning e o zooming.

![Mapa][3]

## Plotando os marcadores

O próximo passo é plotar os marcadores no mapa, o MapKit oferece suporte para adição de imagens nos mapas através de annotations. Para criarmos um annotation devemos informar o seu título e as suas coordenadas. Após sua criação, será exibido um pin vermelho, no entanto, também é possível a customização do annotation para a exibição de outras imagens.

### Criando a classe que representará as informações

Para a representação das informações criaremos uma classe de nome `WorldCupInfo` que irá armazenar o título (nome do país ou do estádio) e suas coordenadas geográficas (latitude e longitude).


{% highlight c# %}
public class WorldCupInfo
{
	public WorldCupInfo ()
	{
	}

	public string Title {
		get;
		set;
	}

	public double Latitude {
		get;
		set;
	}

	public double Longitude {
		get;
		set;
	}
}
{% endhighlight %}

### Inicializando a lista de países e estádios

Após a criação da classe é necessário a criação da lista de estádios e seleções que estão fazendo parte da copa do mundo. Para isso criaremos um atributo para representar a lista no controller assim como um método que irá ser o responsável pela inicialização da lista.

No método GetInfoList eu utilizei a matrix para economizar espaço ao exibir o post.


{% highlight c# %}
protected MKMapView map;
private List<WorldCupInfo> _infoList;

public WorldCupMapViewController (IntPtr handle) : base (handle)
{
	_infoList = GetInfoList ();
}

public List<WorldCupInfo> GetInfoList ()
{
	var infoMatrix = new object[][] {
		new object[] {"Algeria", 28.667122,2.677408},
		new object[] {"Argentina", -35.003106,-64.741499},
		new object[] {"Australia", -24.734834,134.248120},
		new object[] {"Belgium", 50.503887,4.469936},
		new object[] {"Bosnia and Herzegovina", 42.5564516,15.7223665},
		new object[] {"Brazil", -14.235004,-51.92528},
		new object[] {"Cameroon", 7.369721999999999,12.354722},
		new object[] {"Chile", -35.675147,-71.542969},
		new object[] {"Colombia", 4.570868,-74.29733299999999},
		new object[] {"Costa Rica", 9.748916999999999,-83.753428},
		new object[] {"Côte d'Ivoire", 7.539988999999999,-5.547079999999999},
		new object[] {"Croatia", 45.1,15.2},
		new object[] {"Ecuador", -1.831239,-78.18340599999999},
		new object[] {"England", 52.3555177,-1.1743197},
		new object[] {"France", 46.227638,2.213749},
		new object[] {"Germany", 51.165691,10.451526},
		new object[] {"Ghana", 7.946527,-1.023194},
		new object[] {"Greece", 39.074208,21.824312},
		new object[] {"Honduras", 15.199999,-86.241905},
		new object[] {"Iran", 32.427908,53.688046},
		new object[] {"Italy", 41.87194,12.56738},
		new object[] {"Japan", 36.204824,138.252924},
		new object[] {"Korea Republic", 35.907757,127.766922},
		new object[] {"Mexico", 23.634501,-102.552784},
		new object[] {"Netherlands", 52.132633,5.291265999999999},
		new object[] {"Nigeria", 9.081999,8.675276999999999},
		new object[] {"Portugal", 39.39987199999999,-8.224454},
		new object[] {"Russia", 61.52401,105.318756},
		new object[] {"Spain", 40.46366700000001,-3.74922},
		new object[] {"Switzerland", 46.818188,8.227511999999999},
		new object[] {"Uruguay", -32.522779,-55.765835},
		new object[] {"USA", 37.09024,-95.712891},
		new object[] {"Arena Fonte Nova", -12.97883,-38.5043711},
		new object[] {"Estádio das Dunas", -5.8268266,-35.2124299},
		new object[] {"Estádio Castelão", -3.8072311,-38.5224338},
		new object[] {"Arena Pernambuco", -8.0406496,-35.0082049},
		new object[] {"Arena Amazônia", -3.083142,-60.02810849999999},
		new object[] {"Estádio Nacional (Mané Garrincha)", -15.7835191,-47.899211},
		new object[] {"Arena Pantanal", -15.604017,-56.1216325},
		new object[] {"Arena Corinthians", -23.5453331,-46.4737017},
		new object[] {"Estádio do Maracanã", -22.9121089,-43.2301558},
		new object[] {"Estádio Mineirão", -19.865867,-43.97113150000001},
		new object[] {"Arena da Baixada", -25.4482116,-49.2769866},
		new object[] {"Estádio Beira-Rio", -30.065066,-51.2365144}
	};

	var infoList = new List<WorldCupInfo> ();
	foreach (var info in infoMatrix) {
		infoList.Add (new WorldCupInfo () {
			Title = (string) info[0],
			Latitude = (double) info[1],
			Longitude = (double) info[2]
		});
	}

	return infoList;
}
{% endhighlight %}

### Criação dos annotations

Por último, é necessário a criação dos annotations após a inicialização do mapa.


{% highlight c# %}
public override void LoadView ()
{
	map = new MKMapView (UIScreen.MainScreen.Bounds);
	View = map;

	_infoList.ForEach (x => map.AddAnnotation (new MKPointAnnotation () {
		Title = x.Title,
		Coordinate = new CLLocationCoordinate2D () {
			Latitude = x.Latitude,
			Longitude = x.Longitude
		}
	}));
}
{% endhighlight %}

### Visualizando o resultado

Se tudo ocorreu bem até aqui, ao rodar o aplicativo já teremos no nosso mapa a lista de todos os países e estádios da copa do mundo.

![Mapa com pins][4]

## Customizando os marcadores

Para customizar os marcadores, primeiro, vamos precisar adicionar o nome da imagem à classe que estamos utilizando para representar os países e os estádios e depois criaremos o método que vai ser utilizado para obter as novas imagens ao invés dos pins vermelhos.

### Adicionado a imagem a classe WorldCupInfo

Primeiro vamos adicionar a propriedade Image na classe WorldCupInfo.

{% highlight c# %}
public class WorldCupInfo
{
	public WorldCupInfo ()
	{
	}

	public string Title {
		get;
		set;
	}

	public double Latitude {
		get;
		set;
	}

	public double Longitude {
		get;
		set;
	}

	public string Image {
		get;
		set;
	}
}
{% endhighlight %}

E precisamos adicionar o nova propriedade na inicialização da lista e na conversão para a classe WorldCupInfo.

{% highlight c# %}
public List<WorldCupInfo> GetInfoList ()
{
	var infoMatrix = new object[][] {
		new object[] {"Algeria", 28.667122,2.677408, "algeria.png" },
		new object[] {"Argentina", -35.003106,-64.741499, "argentina.png" },
		new object[] {"Australia", -24.734834,134.248120, "australia.png" },
		new object[] {"Belgium", 50.503887,4.469936, "belgium.png" },
		new object[] {"Bosnia and Herzegovina", 42.5564516,15.7223665, "bosnia.png" },
		new object[] {"Brazil", -14.235004,-51.92528, "brazil.png" },
		new object[] {"Cameroon", 7.369721999999999,12.354722, "cameroon.png" },
		new object[] {"Chile", -35.675147,-71.542969, "chile.png" },
		new object[] {"Colombia", 4.570868,-74.29733299999999, "colombia.png" },
		new object[] {"Costa Rica", 9.748916999999999,-83.753428, "costa-rica.png" },
		new object[] {"Côte d'Ivoire", 7.539988999999999,-5.547079999999999, "cote-ivoire.png" },
		new object[] {"Croatia", 45.1,15.2, "croatia.png" },
		new object[] {"Ecuador", -1.831239,-78.18340599999999, "ecuador.png" },
		new object[] {"England", 52.3555177,-1.1743197, "england.png" },
		new object[] {"France", 46.227638,2.213749, "france.png" },
		new object[] {"Germany", 51.165691,10.451526, "germany.png" },
		new object[] {"Ghana", 7.946527,-1.023194, "ghana.png" },
		new object[] {"Greece", 39.074208,21.824312, "greece.png" },
		new object[] {"Honduras", 15.199999,-86.241905, "honduras.png" },
		new object[] {"Iran", 32.427908,53.688046, "iran.png" },
		new object[] {"Italy", 41.87194,12.56738, "italy.png" },
		new object[] {"Japan", 36.204824,138.252924, "japan.png" },
		new object[] {"Korea Republic", 35.907757,127.766922, "korea.png" },
		new object[] {"Mexico", 23.634501,-102.552784, "mexico.png" },
		new object[] {"Netherlands", 52.132633,5.291265999999999, "netherlands.png" },
		new object[] {"Nigeria", 9.081999,8.675276999999999, "nigeria.png" },
		new object[] {"Portugal", 39.39987199999999,-8.224454, "portugal.png" },
		new object[] {"Russia", 61.52401,105.318756, "russia.png" },
		new object[] {"Spain", 40.46366700000001,-3.74922, "spain.png" },
		new object[] {"Switzerland", 46.818188,8.227511999999999, "switzerland.png" },
		new object[] {"Uruguay", -32.522779,-55.765835, "uruguay.png" },
		new object[] {"USA", 37.09024,-95.712891, "usa.png" },
		new object[] {"Arena Fonte Nova", -12.97883,-38.5043711, "fonte-nova.jpeg" },
		new object[] {"Estádio das Dunas", -5.8268266,-35.2124299, "arena-dunas.jpg" },
		new object[] {"Estádio Castelão", -3.8072311,-38.5224338, "estadio-castelao.jpg" },
		new object[] {"Arena Pernambuco", -8.0406496,-35.0082049, "arena-pernambuco.jpg" },
		new object[] {"Arena Amazônia", -3.083142,-60.02810849999999, "arena-amazonia.jpg" },
		new object[] {"Estádio Nacional (Mané Garrincha)", -15.7835191,-47.899211, "estadio-nacional.jpg" },
		new object[] {"Arena Pantanal", -15.604017,-56.1216325, "arena-pantanal.jpg" },
		new object[] {"Arena Corinthians", -23.5453331,-46.4737017, "arena-corinthians.jpg" },
		new object[] {"Estádio do Maracanã", -22.9121089,-43.2301558, "estadio-maracana.jpg" },
		new object[] {"Estádio Mineirão", -19.865867,-43.97113150000001, "estadio-mineirao.jpg" },
		new object[] {"Arena da Baixada", -25.4482116,-49.2769866, "arena-baixada.jpg" },
		new object[] {"Estádio Beira-Rio", -30.065066,-51.2365144, "arena-beira-rio.jpg" }
	};

	var infoList = new List<WorldCupInfo> ();
	foreach (var info in infoMatrix) {
		infoList.Add (new WorldCupInfo () {
			Title = (string) info[0],
			Latitude = (double) info[1],
			Longitude = (double) info[2],
			Image = (string) info[3]
		});
	}

	return infoList;																																																
}
{% endhighlight %}

### Customizando as imagens

Os mapas no Xamarin.iOS lidam com os annotations através do padrão delegate. Ao setarmos uma instância da classe MKMapViewDelegate na propriedade Delegate do nosso mapa estamos transferindo a responsabilidade de interagir com as annotations para a nova classe. Exemplos de propriedades que podem ser customizadas através do delegate é a exibição das imagens e os eventos de clicks. Para customizar as imagens no mapa, vamos criar uma nova classe que herda de MKMapViewDelegate e sobreescreve a exibição da annotation. O delegate também irá guardar uma referência para a lista de informações para que seja possível identificar qual a imagem que irá ser exibida.

Segue o código abaixo.

{% highlight c# %}
class MyMapDelegate : MKMapViewDelegate
{
	private List<WorldCupInfo> _infoList;

	public MyMapDelegate(List<WorldCupInfo> infoList) 
	{
		_infoList = infoList;
	}

	string pId = "PinAnnotation";

	public override MKAnnotationView GetViewForAnnotation (MKMapView mapView, NSObject annotation)
	{
		MKAnnotationView anView;

		if (annotation is MKUserLocation)
			return null; 

		// create pin annotation view
		anView = (MKPinAnnotationView)mapView.DequeueReusableAnnotation (pId);

		if (anView == null)
			anView = new MKPinAnnotationView (annotation, pId);

		var pointAnnotation = (MKPointAnnotation) annotation;
		var info = _infoList.Find (x => x.Title == pointAnnotation.Title);					

		anView.Image = GetImage (info.Image);
		anView.CanShowCallout = true;

		return anView;
	}

	public UIImage GetImage(string imageName)
	{
		var documents =
			Environment.GetFolderPath (Environment.SpecialFolder.Resources);

		var filename = Path.Combine (documents, imageName);

		var image = UIImage.FromFile (filename).Scale(new SizeF() {Height=20, Width=30});

		return image;
	}
}
{% endhighlight %}

Por último, é necessário associar o delegate ao mapa, para isso vamos fazer a seguinte alteração no código de criação do mapa.


{% highlight c# %}
public override void LoadView ()
{
	map = new MKMapView (UIScreen.MainScreen.Bounds);
	map.Delegate = new MyMapDelegate (_infoList);
	View = map;

	_infoList.ForEach (x => map.AddAnnotation (new MKPointAnnotation () {
		Title = x.Title,
		Coordinate = new CLLocationCoordinate2D() {
			Latitude = x.Latitude,
			Longitude = x.Longitude
		}
	}));
}
{% endhighlight %}

### Visualizando o resultado final

Ao final desse artigo, poderemos visualizar um mapa com todos os países e estádios da copa do mundo com suas respectivas imagens. Para aqueles que quiserem acesso ao código, o mesmo se encontra [disponível no github da OnceDev][6].


![Mapa com imagens][5]

[1]: /content/img/blog/posts/2014-07-05/criando-aplicacao.png 
[2]: /content/img/blog/posts/2014-07-05/estrutura-projeto.png
[3]: /content/img/blog/posts/2014-07-05/mapa.png
[4]: /content/img/blog/posts/2014-07-05/mapa-pin.png
[5]: /content/img/blog/posts/2014-07-05/mapa-image.png
[6]: https://github.com/Oncedev/WorldCupMap



