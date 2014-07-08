---
layout: post
title:  "Criando um mapa da copa do mundo usando o Xamarin.iOS"
date:   2014-07-05 14:17:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile 
---

Tempo de copa no Brasil é impossível programar sem ao menos dividir a atenção entre o monitor do computador e a peleja rolando na TV. Mas não é só os jogos da copa que estão emocionantes, a capacidade de usar uma única linguagem para programar o servidor e aplicações mobile NATIVAS tem me empolgado bastante e a experiência tem sido bastante valiosa. Mas por que não juntar as duas paixões e fazer um post demonstrando um dos recursos do Xamarin para visualizar informações sobre a copa do mundo?

Nesse post pretendo mostrar um passo a passo em como podemos utilizar mapas no Xamarin.iOS e usa-lo para plotar informações sobre as seleções e os estádios da copa do mundo. Iremos seguir usando baby steps na seguinte sequência:

1. Criação de uma aplicação no Xamarin
2. Criação do mapa
3. Plotando pontos no mapa
4. Criando uma tela de detalhe
5. Customizando a tela de detalhe
6. Done

<br/>

## Criação de uma aplicação no Xamarin

O primeiro passo que iremos dar é criar uma aplicação no Xamarin chamada WorldCupMap. Para isso acesse File > New > Solution e crie um novo projeto conforme as configurações da imagem abaixo.

![Criando aplicacao][1]

### Analisando a estrutura do projeto

Após a criação do projeto, o Xamarin automaticamente cria uma estrutura com alguns arquivos. Vamos falar sobre a importância de alguns deles.

![Estrutura do Projeto][2]

[1]: /content/img/blog/posts/2014-07-05/criando-aplicacao.png 
[2]: /content/img/blog/posts/2014-07-05/estrutura-projeto.png


