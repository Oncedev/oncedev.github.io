---
layout: post
title:  "Anatomia de um aplicativo Xamarin.Forms"
date:   2015-03-18 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Olá pessoal, dando continuidade aos posts sobre o Xamarin.Forms, dessa vez vou falar sobre como criar nosso primeiro aplicativo usando o Xamarin.Forms e quais são os principais projetos e arquivos que devemos levar em consideração.

### Criando o primeiro aplicativo

Nesse exemplo estarei utilizando o [Xamarin Studio, a IDE oficial da Xamarin][1], o Xamarin Studio, assim como o Visual Studio, já vem com algumas opções de templates que nos ajudam a economizar algum tempo quando vamos criar um projeto, felizmente, existe também um template para a criação de aplicativos Xamarin.Forms. Para criar um aplicativo usaremos o template marcado na figura abaixo, o nosso primeiro app, com muita originalidade, se chamará `MyFirstApp`.

![Criando o primeiro projeto][2]

Após a criação da solução, o template já nos traz alguns projetos prontos, são eles o `MyFirstApp`, o `MyFirstApp.Droid` e o `MyFirstApp.iOS`, conforme a figura abaixo.

![Primeiro projeto criado][3]

### MyFirstApp, o projeto compartilhado

![Projeto Compartilhado em Detalhes][4]

Muito se fala sobre a produtividade e o compartilhamento de código no Xamarin, e é através desse projeto que essa mágica acontece, nesse projeto vamos colocar o código responsável pelas regras de negócio, criação de páginas, viewmodels, acesso a banco de dados e acesso a webservices, resumindo, a idéia aqui é tentar colocar o máximo possível de código. Esse projeto então vai ser consumido por projetos específicos de cada plataforma, no nosso caso, o `MyFirstApp.Droid` e o `MyFirstApp.iOS`. O código abaixo merece comentários:

{% highlight c# %}
public class App : Application
{
	public App ()
	{
		// The root page of your application
		MainPage = new ContentPage {
			Content = new StackLayout {
				VerticalOptions = LayoutOptions.Center,
    				Children = {
						new Label {
							XAlign = TextAlignment.Center,
							Text = "Welcome to Xamarin Forms!"
						}
					}
				}
			};
	}

	protected override void OnStart ()
	{
		// Handle when your app starts
	}

	protected override void OnSleep ()
	{
		// Handle when your app sleeps
	}

	protected override void OnResume ()
	{
		// Handle when your app resumes
	}
}
{% endhighlight %}

O código acima mostra a criação da classe `App`, o entry point do projeto compartilhado, nessa classe é criada a pagina inicial do aplicativo, são definidos alguns eventos do ciclo de vida da aplicação assim como também podem ser colocado informações que são comuns à diferentes páginas da aplicação, um exemplo desse tipo de informação pode ser um objeto com algumas características do usuário logado ou os últimos filtros utilizados durante a sessão atual.

### MyFirstApp.Droid

![Projeto Android em Detalhes][5]

Um desenvolvedor Android desavisado poderia facilmente confundir esse projeto com qualquer outro projeto criado no [Android Studio][7], nesse projeto nós vamos colocar tudo que vai ser específico da versão Android, imagens, customizações de controles ou layouts e implementações de classes que acessam alguma API Nativa do Android, como por exemplo, voz, acesso à arquivos e NFC.

{% highlight c# %}
[Activity (Label = "MyFirstApp.Droid", Icon = "@drawable/icon", 
		MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsApplicationActivity
{
	protected override void OnCreate (Bundle bundle)
	{
		base.OnCreate (bundle);

		global::Xamarin.Forms.Forms.Init (this, bundle);

		LoadApplication (new App ());
	}
}
{% endhighlight %}

Assim como nos aplicativos Android escritos em Java, em um aplicativo Xamarin.Forms, a `MainActivity` também é o entry point e o desejável, embora nem sempre isso aconteça, é que ela seja a única activity do projeto e que saia de cena após invocar o entry point do projeto compartilhado. Na `MainActivity` também podem ser configurados injeções de dependência, serviços de analytics, crash reports e qualquer outra funcionalidade que precise ser inicializada a partir de um projeto Android.

### MyFirstApp.iOS

![Projeto iOS em Detalhes][6]

Se um desenvolvedor Android poderia facilmente se confundir ao abrir o projeto Android em um aplicativo Xamarin, o mesmo vale para o desenvolvedor iOS, as pastas, a forma de nomear as imagens e os arquivos são os mesmos. Assim como acontece no `MyFirstApp.Droid`, nesse projeto iremos colocar código específico para o iOS (customizações de controles, uso de APIs nativas e etc). A figura abaixo mostra um print do arquivo `Info.plist`, como podemos ver é igual ao que encontramos quando criamos o aplicativo no [XCode][8].

![Info.plist Info][9]
![Info.plist Icons][10]

No iOS, o entry point se chama `Main` e assim como acontece no iOS com o objective-C, ele vai chamar a classe `AppDelegate` que vai servir para invocar o entry point do nosso projeto compartilhado, assim como na `MainActivity`, é nessa classe que vamos colocar qualquer configuração que deva ser feita a partir de um projeto iOS, como injeções de dependência, serviços de analytics, crash reports e por aí vai.

### Era isso!

Nesse post eu quis mostrar como se cria um aplicativo usando o Xamarin.Forms, qual a sua estrutura inicial e a responsabilidade de cada peça nessa estrutura, nos próximos posts vou falar mais a fundo sobre as Pages, Layouts e os Controls que são os componentes que usamos para criar as telas dos aplicativos. Até breve!

[1]: http://xamarin.com/studio
[2]: /content/img/blog/posts/2015-03-09/creating-first-app.png
[3]: /content/img/blog/posts/2015-03-09/project-created.png
[4]: /content/img/blog/posts/2015-03-09/core-detailed.png
[5]: /content/img/blog/posts/2015-03-09/droid-detailed.png
[6]: /content/img/blog/posts/2015-03-09/ios-detailed.png
[7]: http://developer.android.com/tools/studio/index.html
[8]: https://developer.apple.com/xcode/
[9]: /content/img/blog/posts/2015-03-09/infoplist-info.png 
[10]: /content/img/blog/posts/2015-03-09/infoplist-icons.png 
