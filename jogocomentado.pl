/*Tutorial do Jogo*/

/*Digite "tutorial." para conhecer as regras do jogo*/
tutorial :-
    writeln(' '),
    write('================================= TUTORIAL ================================='), nl, nl,
    write('Bem-vindo(a) ao tutorial!'), nl, nl,
    write('O jogo funciona da seguinte forma: '),
    write('O jogador deve pensar em um personagem e em suas caracteristicas e iniciar o jogo!'), nl,
    write('Ao iniciar o jogo, o programa perguntara sobre caracteristicas do seu personagem ate que consiga adivinhar!'), nl, nl, nl,
    write('Regras basicas:'), nl, nl,
    write('1- O personagem deve ser do mundo dos games!'), nl,
    write('2- As perguntas devem ser respondidas com a verdade!'), nl,
    write('3- As perguntas devem ser respondidas apenas com "sim" ou "nao"!'), nl,
    write('4- Voce ganha se eu nao conhecer seu personagem, ou adivinhar errado!'), nl, nl, nl,
    write('Digite "jogar." para comecar!'), nl, nl,
    write('================================= TUTORIAL =================================').





/*
************************************************************************************************
* Base de dados dos personagens usa o predicado personagem(nome, [lista de caracteristicas]);  *
* Esse formato é util, compacto e bem organizado;                                              *
* OBS: NAO INCLUIR PERSONAGENS COM LISTA DE CARACTERISTICAS IDENTICAS!                         *
****************************************************************** *****************************
*/
personagem(mario, [bom, humano, masculino, gordinho]).
personagem(luigi, [bom, humano, masculino, magro]).
personagem(peach, [bom, humano, feminino, magro]).
personagem(bowser, [mal, monstro, masculino, gordinho]).
personagem(ganon, [mal, humano, masculino, forte]).
personagem(mario, [humano, bom, masculino, vermelho, encanador, gordinho]).
personagem(luigi, [humano, bom, masculino, verde, encanador]).
personagem(peach, [humano, bom, feminino, rosa, princesa]).
personagem(Link, [humano, bom, masculino, verde, guerreiro]).
personagem(bowser, [monstro, mal, masculino, rei, espinhoso]).
personagem(ganon, [humano, mal, masculino, rei, forte]).
personagem(yoshi,[dinossauro, bom, verde]).
personagem(waluigi,[humano, mal, masculino, alto, magro]).
personagem(wario,[humano, mal, masculino, baixo]).
personagem(isabelle,[animal, bom, cachorro]).
personagem(tom_nook,[animal, bom, guaxinim, capitalista]).
personagem(donkey_kong,[animal, mal, macaco, grande]).
personagem(diddy_kong, [animal, bom, macaco, pequeno]).
personagem(toad,[cogumelo, bom, masculino]).
personagem(toadette,[cogumelo, bom, feminino]).
personagem(jigglypuff, [pokemon, fada, rosa]).
personagem(rayquaza, [pokemon, voador, dragao, lendario, verde]).
personagem(charizard, [pokemon, voador, flamejante]).
personagem(arceus, [pokemon, lendario, divindade]).
personagem(arceus, [pokemon, lendario, psiquico]).
personagem(pikachu,[pokemon, eletrico, amarelo]).
personagem(impa,[humano, bom, feminino, sabio, velho]).
personagem(epona,[animal, bom, cavalo, leal]).
personagem(rover,[animal, gato, viajante]).
personagem(samus,[humano, bom, feminino, bounty_hunter]).
personagem(kirby,[fofo, rosa, redondo]).
personagem(zelda, [humano, bom, feminino, princesa, sabio]).




/*
**********************************************************************************************************
*  A funcao jogar inicia o jogo utilizando findall para armazenar os personagens da base de dados na     *
*  lista _personagens e dá início ao processo de adivinhação, começando com uma lista vazia de perguntas * 
*  feitas.                                                                                               *
**********************************************************************************************************
*/

jogar :-
    findall(P, personagem(P, _), _personagens),
    adivinha_personagens(_personagens, []).





/*
*************************************************************************************************************
* A funcao adivinha_personagens eh a parte principal do programa. Ela processa a lista de personagens ateh  *
* que reste apenas um ou nenhum personagem. A funcao realiza perguntas e filtragens, chamando a si mesma de *
* forma recursiva até alcancar o resultado desejado, de forma a fornecer a saida apropriada em cada caso.   *
*************************************************************************************************************
*/

/*
**************************************************************
* Ainda executando o processo de adivinhacao do personagem:  *
**************************************************************
*/

adivinha_personagens(_personagens, _perguntas_feitas) :-
    pergunta(_personagens, _perguntas_feitas, _pergunta),
    write('Seu personagem eh: '), write(_pergunta), write('? '),
    read(_resposta),
    filtragem(_personagens, _pergunta, _resposta, _personagens_filtrados),
    adivinha_personagens(_personagens_filtrados, [_pergunta | _perguntas_feitas]).


/*
******************************************
* Acha que descobriu o personagem certo. *
******************************************
*/

adivinha_personagens([_personagem], _) :-
    write('Acho que o seu personagem eh: '), write([_personagem]), writeln('!?'),

    read(_resposta),

    (_resposta = sim -> writeln('Eu acertei!'); writeln('Eu perdi!')),
    !.

/*
**************************************************************************************************************************
* A lista de personagens ficou vazia, indicando que o personagem nao esta na base de dados; neste caso o jogador venceu. *
**************************************************************************************************************************
*/

adivinha_personagens([], _) :-
    writeln('Eu nao conheco o personagem que voce estava pensando, eu perdi!'), !.


/*
***************************************************************************************************************
* Essa funcao garante que nao haja repeticao de perguntas, pois o programa seleciona uma carecteristica do    *
* primeiro personagem na lista de possiveis personagens e a utilizada para fazer a pergunta. A funcao compara *
* essa caracteristica com a lista de _perguntas_feitas e procede de acordo com o resultado, evitando          *
* redundancias.                                                                                               *
***************************************************************************************************************
*/

pergunta([_personagem | _], _perguntas_feitas, _pergunta) :-
    personagem(_personagem, _caracteristicas),
    member(_pergunta, _caracteristicas),
    \+ member(_pergunta, _perguntas_feitas), !.

pergunta([_ | Restantes], _perguntas_feitas, _pergunta) :-
    pergunta(Restantes, _perguntas_feitas, _pergunta).


/*
****************************************************************************************************************************
* Executa a filtragem removendo os personagens adequados com base na pergunta feita e na resposta recebida.                *
* Os personagens filtrados, que representam as opções possíveis, são armazenados na lista _personagens_filtrados, para que *
* todo o processo possa ser repetido.                                                                                      *
****************************************************************************************************************************
*/

/* 
**************************
* Faz nada quando vazia. *
**************************
*/

filtragem([], _, _, []).

/*
*****************************************************************************************************************
* Remove os personagens que não possuem a característica perguntada, pois a resposta a essa pergunta foi 'sim'. *
*****************************************************************************************************************
*/

filtragem([_personagem | _resto], _pergunta, sim, [_personagem | _personagens_filtrados]) :-
    personagem(_personagem, _caracteristicas),
    member(_pergunta, _caracteristicas),
    filtragem(_resto, _pergunta, sim, _personagens_filtrados).

/*
*****************************************************************************************************************
* Remove os personagens que não possuem a característica perguntada, pois a resposta a essa pergunta foi 'sim'. *
*****************************************************************************************************************
*/

filtragem([_personagem | _resto], _pergunta, nao, [_personagem | _personagens_filtrados]) :-
    personagem(_personagem, _caracteristicas),
    \+ member(_pergunta, _caracteristicas),
    filtragem(_resto, _pergunta, nao, _personagens_filtrados).


filtragem([_ | _resto], _pergunta, _resposta, _personagens_filtrados) :-
    filtragem(_resto, _pergunta, _resposta, _personagens_filtrados).
