---
layout: post
title:  "Quer ser um cliente feliz? Pergunte-me como!"
date:   2015-04-15 08:50:00
author: vladsonfreire
categories: agilidade
tags: Agilidade 
---

Antes de você continuar a leitura, escute a empolgação do nosso cliente ao falar do projeto que estamos entregando.

<div class="iframe soundcloud"><iframe scrolling="no" frameborder="0" id="player" src="https://w.soundcloud.com/player/?visual=true&amp;url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F198831738&amp;show_artwork=true" allowfullscreen="true"></iframe></div>

Se você não é da área de tecnologia, fique sabendo que infelizmente situações de sucesso como esta não são tão comuns.

Em uma pesquisa realizada por SCOTT AMBLET + Associates, apenas 50% dos entrevistados que utilizavam modelo tradicional de desenvolvimento ([Cascata][3]) ou [Ad-Hoc][4] (Nenhum modelo) consideraram que o software desenvolvido pelas suas empresas obtiveram o sucesso esperado. Para os entrevistados que utilizavam metodologias como Lean, Iterative ou Agile a taxa de sucesso variou entre 65% a 70%.

![How successful are software delivery teams?][1]

Para classificar o sucesso do projeto, AMBLER não utilizou os critérios do triângulo das restrições: Escopo, Recurso (Custo) e Prazo. Ele considerou que cada time possui a sua definição de sucesso e as respostas dos entrevistados comprovou a sua teoria, pois apenas 1 em cada 10 profissionais definiu a tríplice: Escopo, Recurso e Prazo, como definição de sucesso dos seus projetos.

![How do you define software development success?][2]

Para este projeto, escolhemos a Especificação e o Prazo como indicadores de sucesso do projeto. Estes dois indicadores foram selecionados, porque fomos contratados apenas por 60 dias ou 4 Sprints de 15 dias cada (Prazo) e a Especificação do projeto ficou focada na construção da nova tela de programação musical da rádio do cliente.

A Oncedev, empresa que eu trabalho, utiliza metodologia ágil no desenvolvimento dos seus projetos, mas como vimos no primeiro gráfico, ainda tínhamos 35% de chance de falharmos e esses 35% se multiplicaram por 2 durante a [Inception Meeting][5] quando fomos apresentados ao sistema legado feito em Powerbuilder, mas cheio de drag and drop. Uau!! Como os caras conseguiram fazer isso há 10 anos atrás?

Terminada a reunião, sabíamos que o desafio era enorme. Além da dificuldade tecnológica em utilizar uma versão antiga do [Ext.js][6] customizada pelo cliente, tínhamos a obrigação deixá-lo satisfeito com a nova versão do sistema, tornando o trabalho dos usuários mais eficiente.

Como estratégia inicial, dividimos a equipe em duas. Uma equipe seria responsável por desenvolver a parte do projeto que não possuía grandes desafios tecnológicos e a outra seria responsável por desenvolver a solução da tela de programação musical que possuía os seguintes requisitos:

1. Possibilitar que o usuário configurasse a programação de um dia inteiro hora a hora;
2. Permitir que o usuário mudasse as musicas de posição e de uma hora para outra através do arrastar e soltar;
3. Gerar formas diferentes de visualização através de zoom in e zoom out;
4. Criar um mecanismo de salvar automaticamente as alterações realizadas pelo usuário;
5. Sortear todas as músicas de um dia de programação automaticamente.

O primeiro Sprint da equipe responsável pelo desenvolvimento da tela de programação musical, foi um [Sprint Spike][7]. O objetivo deste Sprint era desenvolver uma solução tecnológica capaz de satisfazer os requisitos 1, 2 e 3 dentro da arquitetura pré-existente ou através do emprego de uma nova tecnologia. Ao final do spike, o time apresentou uma ótima solução utilizando novas tecnologias, mas que gerava grande impacto ao restante da equipe do cliente que não possuía o conhecimento destas novas tecnologias, e uma solução não tão boa, mas que foi construída utilizando a arquitetura do restante do projeto e que o time do cliente dominava.

Neste momento de decisão, a confiança do [P.O.][8] (Product Owner) no time permitiu a escolha do caminho mais difícil a curto prazo, pois era necessário realizar modificações na solução que estava sendo utilizada no restante do projeto, mas que a longo prazo, não geraria necessidade de aprendizado de uma nova tecnologia por parte da equipe que seria responsável por manter o produto.

Restou ao time a tarefa de evoluir a solução escolhida, realizando as adaptações necessárias na arquitetura do projeto para poder gerar uma solução que atendesse as necessidades do projeto.

Ter um time ágil em sua essência foi primordial para entregarmos o projeto com sucesso. Um time que foi capaz de superar as suas limitações técnicas apenas para poder surpreender o Cliente e arrancar o seu sorriso no dia da entrega. Um time que, mesmo recebendo um feedback positivo do cliente, é capaz de zerar a sua autoestima para poder ouvir novamente que o projeto está ficando excelente. Um time que estava 100% focado em gerar o máximo de valor possível para o cliente.

A cada final de Sprint, a interação entre o time (Cliente + [Scrum Master][9] + Desenvolvedores) aumentou bastante e o resultado dessa sinergia foi a construção de um produto que atendeu 100% do escopo definido dentro do prazo.

Se você deseja ser um Cliente Feliz. Pergunte-me como!

[1]: /content/img/blog/posts/2015-04-15/success-software-teams.png
[2]: /content/img/blog/posts/2015-04-15/define-success-software-projects.png 
[3]: http://pt.wikipedia.org/wiki/Modelo_em_cascata
[4]: http://pt.wikipedia.org/wiki/Ad_hoc
[5]: http://www.linguee.com/english-portuguese/translation/inception+meeting.html
[6]: http://www.sencha.com/products/extjs/
[7]: http://www.scaledagileframework.com/spikes/
[8]: http://en.wikipedia.org/wiki/Scrum_%28software_development%29#Product_Owner
[9]: http://en.wikipedia.org/wiki/Scrum_%28software_development%29#Scrum_Master
