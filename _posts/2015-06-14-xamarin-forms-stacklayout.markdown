---
layout: post
title:  "Xamarin Forms: StackLayout"
date:   2015-06-14 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Olá pessoal, tudo bom? Depois de um pequeno hiato, volto aqui no blog para abrir a seção de Layouts e o primeiro representante dessa seção é o StackLayout.

### Layouts

![Layouts][5]

Os Layouts no Xamarin Forms servem para organizar os nossos controles na tela, como por exemplo, para organização de campos de um formulário, organização de listagens, fixar um determinado botão na parte inferior de uma tela e etc. 
Existem 7 tipos de Layouts na API do Xamarin Forms são eles: o `StackLayout`, o `AbsoluteLayout`, o `RelativeLayout`, o `GridLayout`, a `ContentView`, a `ScrollView` e o `Frame`. Nesse post vamos falar sobre o primeiro deles, o StackLayout.

### StackLayout

O `StackLayout` é a forma mais simples de organização de controles, nele, com o próprio nome diz, organizamos os nossos componentes empilhados(Stack == pilha) um após o outro. Para setar o conteúdo em um StackLayout nós usamos a propriedade `Children`, no código abaixo, usamos um StackLayout para exibir uma sequência de letras na vertical em uma [ContentPage][6].

{% highlight c# %}
public class VerticalLetters : ContentPage
{
	public VerticalLetters ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0));
		Content = new StackLayout () {					
			Children = {
				new Label() {Text="A", FontSize = 30},
				new Label() {Text="B", FontSize = 30},
				new Label() {Text="C", FontSize = 30},
				new Label() {Text="D", FontSize = 30},
				new Label() {Text="E", FontSize = 30}
			}
		};
	}
}  
{% endhighlight %}

Ao executar o código acima em ambas as plataformas temos o mesmo comportamento.

![StackLayout na Vertical][1]

### Orientação

O StackLayout possui dois tipos de orientação, por default, o StackLayout exibe seus filhos na orientação vertical, mas também podemos setar a propriedade `Orientation` para Horizontal e ver agora as letras na horizontal.

{% highlight c# %}
public class HorizontalLetters : ContentPage
{
	public HorizontalLetters ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0));
		Content = new StackLayout () {					
			Orientation = StackOrientation.Horizontal,
			Children = {
				new Label() {Text="A", FontSize = 30},
				new Label() {Text="B", FontSize = 30},
				new Label() {Text="C", FontSize = 30},
				new Label() {Text="D", FontSize = 30},
				new Label() {Text="E", FontSize = 30}
			}
		};
	}
}
{% endhighlight %}

Ao executar o código acima em ambas as plataformas temos as letras agora na horizontal.

![StackLayout na Horizontal][2]

### Espaçamento

Uma outra propriedade útil do StackLayout é a `Spacing`, que nos permite definir o espaçamento entre cada filho do Layout, por default, esse valor é setado como 6.

Setando esse valor como 50, nós observamos essas letras bem separadas.

{% highlight c# %}
public class VerticalLetters : ContentPage
{
	public VerticalLetters ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0));
		Content = new StackLayout () {	
			Spacing = 50,
			Children = {
				new Label() {Text="A", FontSize = 30},
				new Label() {Text="B", FontSize = 30},
				new Label() {Text="C", FontSize = 30},
				new Label() {Text="D", FontSize = 30},
				new Label() {Text="E", FontSize = 30}
			}
		};
	}
}
{% endhighlight %}

![StackLayout com Spacing][3]

### Criando um formulário de login

![Formulário com StackLayout][4]

O cenário mais comum é combinar diferentes layouts para atingir a interface que queremos, nesse exemplo vamos utilizar alguns StackLayouts para criar um formulário de login de acordo com a imagem acima.

Para tal, vamos usar 3 StackLayouts, um para o par descrição + campo para o nome do usuário (User), um para o par descrição + campo para a senha (Password) e um terceiro para juntar os dois anteriores e mais um botão de login.

Segue o código abaixo:

{% highlight c# %}
public class LoginForm : ContentPage
{
	public LoginForm ()
	{
		Padding = new Thickness (5, Device.OnPlatform (20, 0, 0), 5, 0);
		
		var userLabel = new Label () {
			Text = "User:", 
			WidthRequest = 100
		};
		var userEntry = new Entry () {
			HorizontalOptions = LayoutOptions.FillAndExpand
		};
		var userStack = new StackLayout () {
			Orientation = StackOrientation.Horizontal,
			Children = {userLabel, userEntry}
		};

		var passwordLabel = new Label () {
			Text = "Password:", 
			WidthRequest = 100
		};
		var passwordEntry = new Entry () {
			HorizontalOptions = LayoutOptions.FillAndExpand, 
			IsPassword = true 
		};
		var passwordStack = new StackLayout () {
			Orientation = StackOrientation.Horizontal,
			Children = {passwordLabel, passwordEntry}
		};

		var loginButton = new Button () {Text = "Login"};

		var formStack = new StackLayout () {
			Children = {
				userStack,
				passwordStack,
				loginButton
			}
		};

		Content = formStack;
	}
}
{% endhighlight %}

### É isso aí!

É isso aí pessoal, esse é o `StackLayout`, é um dos mais simples Layouts do `Xamarin.Forms` mas extremamente útil quando precisamos posicionar os nossos elementos de UI de forma sequencial.

Podem esperar que vem muito mais por aí!

[1]: /content/img/blog/posts/2015-06-14/stacklayout.png 
[2]: /content/img/blog/posts/2015-06-14/horizontal-layout.png 
[3]: /content/img/blog/posts/2015-06-14/stacklayout-with-spacing.png
[4]: /content/img/blog/posts/2015-06-14/login-form.png
[5]: /content/img/blog/posts/2015-06-14/layouts.png
[6]: /mobile/2015/04/08/xamarin-forms-usando-pages-parte-1/
