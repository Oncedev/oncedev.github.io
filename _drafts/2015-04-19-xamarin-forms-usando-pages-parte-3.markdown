---
layout: post
title:  "Xamarin Forms: Usando Pages - Parte 3"
date:   2015-04-18 08:50:00
author: pauloortins
categories: Mobile
tags: Xamarin Mobile
---

Esse post fecha a seção sobre Pages aqui no blog, nesse último post mostrarei a MasterDetailPage, exemplos de aplicativos que a utilizam e como é de praxe, um aplicação prática desse tipo de Page. 

### MasterDetailPage

Como o próprio nome evidencia, para mostrar uma dupla de telas onde uma das telas é a tela master, onde normalmente vamos ter uma listagem de dados e outra tela é a tela de detalhe que vai detalhar as informações selecionadas na tela master.

#### MasterDetailPage no SmartPhone

Nos smartphones, pelo seu tamanho reduzido, não conseguimos mostrar a tela Master e a tela Detail ao mesmo tempo, nesse caso, por padrão é exibida a página Detail e ao arrastar a tela lateralmente do canto esquerdo para o canto direito ou ao clicar no botão da barra de navegação a tela Master é deslizada por cima da tela de Detalhe, dessa forma, toda a tela Master é exibida enquanto a tela Detail fica parcialmente escondida.

O exemplo mais recente para aqueles que acompanham as notícias do Xamarin é o app da Xamarin Evolve 2014, nesse app a pagina master atua como menu onde temos os seguintes itens: Sessions, Speakers, Favorites, Places, About e Sponsors, ao selecionar qualquer um desses, a página master se retrai e temos acesso ao conteúdo relativo ao item de menu escolhido.

![Aplicativo Xamarin Evolve][2] 

No iPad, por ter mais espaço na tela, a tela 

![Aplicativo Gmail][1]


 
[1]:
[2]:


