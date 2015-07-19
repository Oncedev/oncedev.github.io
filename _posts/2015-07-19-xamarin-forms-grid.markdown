---
layout: post
title:  "Xamarin Forms: Grid"
date:   2015-07-19 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Olá Xamarineiros! Como estão os seus projetos Xamarin? Tudo numa boa? Espero que sim. Nesse post vou falar de mais um tipo de layout que podemos utilizar nas nossas aplicações [Xamarin.Forms][6], o Grid.

### Grid

![Grid][5]

Se eu tivesse que fazer uma analogia para facilitar o entendimento do que é o `Grid`, a primeira coisa que passaria pela minha cabeça seriam as tables do HTML. No grid, assim como nas tables, nós agrupamos os nossos elementos de UI em linhas e colunas (Rows e Columns). 

Para adicionar um controle ao `Grid` nós utilizamos o método `Add` da coleção `Children`, coleção que contém todos os elementos pertencentes ao Grid. O método Add nos permite inserir elementos no grid de duas formas, vamos a elas:

O método **Add(View item, int left, int top)** adiciona um elemento na coluna representada pelo parâmetro `left` e na linha representada pelo parâmetro `top`.

O exemplo abaixo mostra como podemos usar esse método para distribuir 4 `Labels` em duas linhas e duas colunas.

{% highlight c# %}
public class GridPage : ContentPage
{
	public GridPage()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0), 0, 0);

		var grid = new Grid ();

		grid.Children.Add (new Label () {Text = "(0,0)", BackgroundColor=Color.Aqua}, 0, 0);
		grid.Children.Add (new Label () {Text = "(0,1)", BackgroundColor=Color.Gray}, 1, 0);
		grid.Children.Add (new Label () {Text = "(1,0)", BackgroundColor=Color.Yellow}, 0, 1);
		grid.Children.Add (new Label () {Text = "(1,1)", BackgroundColor=Color.Pink}, 1, 1);

		Content = grid;
	}
}
{% endhighlight %}

Se executarmos o código acima temos o seguinte resultado:

![Grid com 2 linhas e duas colunas][0]

### Criando elementos que ocupam mais de uma coluna/linha

O grid também nos permite ir além de apenas escolher a posição do elemento mas também podemos fazer com que esse elemento ocupe mais de uma coluna ou linha, ou seja, podemos definir o `RowSpan` ou `ColSpan` de cada elemento dentro do nosso grid.

O método **Add(View item, int left, int right, int top, int bottom):** adiciona um elemento na coluna representada pelo parâmetro left e na linha representada pelo parâmetro top, os parâmetros right e bottom servem para definir o limite horizontal e vertical do elemento. Exemplo, ao usar `left=0,right=2,top=1 e bottom=4`, nós estamos definindo um elemento que vai ocupar a coluna 0 e 1 e as linhas 1,2 e 3. Não é muito intuitivo, mas é assim que funciona :D

O exemplo abaixo vai criar os mesmo 4 labels, mas agora eles vão ocupar mais de uma célula dentro do nosso grid: os Labels de cor Aqua e Cinza vão ocupar 2 colunas e 1 linha, o label de cor Amarela irá ocupar 1 coluna e 2 linhas enquanto o Label de cor Rosa irá ocupar 3 colunas e 1 linha. 

O código abaixo mostra como criamos esse grid:

{% highlight c# %}
public class GridPage2 : ContentPage
{
	public GridPage2()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0), 0, 0);

		var grid = new Grid ();

		// Columns 0 and 1 - Row 0		
		grid.Children.Add (new Label () {Text = "(0,0)", BackgroundColor=Color.Aqua}, 0, 2, 0, 1);

		// Columns 0 and 1 - Row 1
		grid.Children.Add (new Label () {Text = "(1,0)", BackgroundColor=Color.Gray}, 0, 2, 1, 2);

		// Column 2 - Rows 0 and 1
		grid.Children.Add (new Label () {Text = "(0,2)", BackgroundColor=Color.Yellow}, 2, 3, 0, 2);

		// Columns 0, 1 and 2 - Row 2
		grid.Children.Add (new Label () {Text = "(2,0)", BackgroundColor=Color.Pink}, 0, 3, 2, 3);

		Content = grid;
	}
}
{% endhighlight %}

Ao executarmos temos o seguinte resultado:

![Grid com linhas e colunas com tamanhos diferentes][1]

### Uma outra forma de criar lementos que ocupam mais de uma coluna/linha

Não só podemos definir a quantidade de colunas e linhas que um elemento vai ocupar usando o método `Add`, também é possível utilizar os métodos `Grid.SetColumnSpan` e `Grid.SetRowSpan`, onde passamos a view e o número de colunas ou linhas que ela ocupará na grid. 

O código abaixo faz o mesmo que o código anterior mas usando os métodos da classe `Grid`.

{% highlight c# %}
public class GridPage3 : ContentPage
{
	public GridPage3 ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0), 0, 0);

		var grid = new Grid ();

		var aqua = new Label () {Text = "(0,0)", BackgroundColor=Color.Aqua};
		grid.Children.Add (aqua, 0, 0);
		Grid.SetColumnSpan (aqua, 2);

		var gray = new Label () { Text = "(1,0)", BackgroundColor = Color.Gray };
		grid.Children.Add (gray, 0, 1);
		Grid.SetColumnSpan (gray, 2);

		var yellow = new Label () { Text = "(0,2)", BackgroundColor = Color.Yellow };
		grid.Children.Add (yellow, 0, 2);
		Grid.SetRowSpan (yellow, 2);

		var pink = new Label () { Text = "(2,0)", BackgroundColor = Color.Pink };
		grid.Children.Add (pink, 0, 2);
		Grid.SetColumnSpan (pink, 3);

		Content = grid;
	}
}
{% endhighlight %}

Ao executarmos o código acima produzimos o mesmo resultado:

![Grid com linhas e colunas com tamanhos diferentes][2]

### Adicionado definições diferentes para cada columa/linha

Eu não sei se você percebeu mas em todas as grids que criamos até o momento as linhas e as colunas possuem exatamente o mesmo tamanho, no entanto, no mundo real isso não acontece, no mundo real nós temos que ser capazes de customizar esses tamanhos e nós podemos fazer isso definindo as RowsDefinitions e as ColumnDefinitions.

O enumeration `GridUnitType` fornece algumas opções de definição de tamanho:

**Absolute:** Seta o tamanho da coluna/linha igual ao número de device-specific-units (dpu)   
**Auto:** Seta o tamanho da célula de acordo com o seu conteúdo.     
**Star:** Seta o tamanho da célula de forma proporcional ao tamanho restante após todas as células com tamanhos definidos de forma `Absolute` ou `Auto` serem renderizadas.   

O exemplo abaixo mostra uma linha com múltiplas colunas, onde a primeira coluna vai ser definida com tipo `Auto`, ou seja, vai ocupar exatamente o suficiente para mostrar a imagem, a segunda coluna vai ter o seu tamanho definido usando o tipo `Absolute` ou seja, vai possuir exatos 40 dpus e por último, a terceira coluna vai ocupar todo o tamanho restante, ou seja, vai ser definida como `Star`.   

{% highlight c# %}
public class GridPage4 : ContentPage
{
	public GridPage4 ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0), 0, 0);
		var grid = new Grid ();

		grid.Children.Add (
			new Image() {
				Source= Device.OnPlatform("Icon-60@2x.png", "icon.png", "")
			}, 0, 0);

		grid.Children.Add (new Label () { Text = "40", BackgroundColor = Color.Yellow}, 1, 0);
		grid.Children.Add (new Label () { Text = "Remainder", BackgroundColor = Color.Pink}, 2, 0);

		grid.ColumnDefinitions.Add (new ColumnDefinition () 
			{
				Width = new GridLength(1, GridUnitType.Auto)
			});

		grid.ColumnDefinitions.Add (new ColumnDefinition () 
			{
				Width = new GridLength(40, GridUnitType.Absolute)
			});

		grid.ColumnDefinitions.Add (new ColumnDefinition () 
			{
				Width = new GridLength(1, GridUnitType.Star)
			});

		Content = grid;
	}
}
{% endhighlight %}

Se executarmos o código acima temos o seguinte resultado:

![Grid com ColumnDefinitions][3]

   
   
O mesmo vale para as linhas.  
  
  
  
{% highlight c# %}
public class GridPage5 : ContentPage
{
	public GridPage5 ()
	{
		Padding = new Thickness (0, Device.OnPlatform (20, 0, 0), 0, 0);
		var grid = new Grid ();

		grid.Children.Add (
			new Image() {
				Source= Device.OnPlatform("Icon-60@2x.png", "icon.png", "")
			}, 0, 0);

		grid.Children.Add (new Label () { Text = "40", BackgroundColor = Color.Yellow}, 0, 1);
		grid.Children.Add (new Label () { Text = "Remainder", BackgroundColor = Color.Pink}, 0, 2);

		grid.RowDefinitions.Add (new RowDefinition () 
			{
				Height = new GridLength(1, GridUnitType.Auto)
			});

		grid.RowDefinitions.Add (new RowDefinition () 
			{
				Height = new GridLength(40, GridUnitType.Absolute)
			});

		grid.RowDefinitions.Add (new RowDefinition () 
			{
				Height = new GridLength(1, GridUnitType.Star)
			});

		Co  ntent = grid;
	}
}
{% endhighlight %}

   
   
Executando o código acima temos o seguinte resultado:  
   
   
   
![Grid com RowDefinitions][4]

### Era isso!

Era isso pessoal, nesse post conseguimos cobrir todas as possibilidades de uso do `Grid` que é bem útil quando tentamos fazer qualquer tela um pouquinho mais complexa.

Qualquer dúvida, sugestão ou crítica pode deixar um comentário!

[0]: /content/img/blog/posts/2015-07-19/grid1.png
[1]: /content/img/blog/posts/2015-07-19/grid2.png
[2]: /content/img/blog/posts/2015-07-19/grid2.png
[3]: /content/img/blog/posts/2015-07-19/grid3.png
[4]: /content/img/blog/posts/2015-07-19/grid4.png
[5]: /content/img/blog/posts/2015-07-19/grid.png
[6]: /mobile/2015/03/08/xamarin-forms/
