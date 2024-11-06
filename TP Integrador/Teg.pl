/* distintos paises */
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, gobi).
paisContinente(asia, india).
paisContinente(asia, iran).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

estaEnContinente(Jugador,Continente):-
    ocupa(Pais,Jugador,_),
    paisContinente(Continente,Pais).

cantidadPaises(Jugador,CantidadPaisesOcupa):-
    paisesOcupados(Jugador,PaisesOcupados),
    length(PaisesOcupados, CantidadPaisesOcupa).
    
paisesOcupados(Jugador,ListaPaises):-
    jugador(Jugador),
    findall(Pais,ocupa(Pais,Jugador,_),ListaPaises).


ocupaContinente(Jugador,Continente):-
    estaEnContinente(Jugador,Continente),
    forall(paisContinente(Continente,Pais),ocupa(Pais,Jugador,_)).

jugador(Jugador):-
    ocupa(_,Jugador,_).

    leFaltaMucho(Jugador, Continente) :-
        estaEnContinente(Jugador, Continente),
        not(ocupaAlMenos2(Jugador, Continente)).
    
    ocupaAlMenos2(Jugador, Continente) :-
        estaEnEsePaisYContinente(Continente, UnPais, Jugador),
        estaEnEsePaisYContinente(Continente, OtroPais, Jugador),
        UnPais \= OtroPais.
    
    estaEnEsePaisYContinente(Jugador, Pais, Continente) :-
        paisContinente(Continente, Pais),
        ocupa(Pais, Jugador,_).

sonLimitrofes(Pais1,Pais2):-
    pais(Pais1),
    pais(Pais2),
    Pais1 \= Pais2,
    member(Pais1,PaisesLimitrofes),
    member(Pais2,PaisesLimitrofes).

pais(Pais):-
    ocupa(Pais,_,_).

esGroso(Jugador):-
    jugador(Jugador),
    forall(paisImportante(Pais),ocupa(Jugador,Pais,_)).
esGroso(Jugador):-
    cantidadPaises(Jugador,CantidadPaisesOcupa),
    CantidadPaisesOcupa > 10.
esGroso(Jugador):-
    findall(Ejercito,ocupa(_,Jugador,Ejercito),Ejercitos),
    sumlist(Ejercitos, CantidadEjercitos),
    CantidadEjercitos > 50.
    
estaEnElHorno(Pais):-
    ocupa(Pais,Jugador,_),
    forall(sonLimitrofes(Pais,OtroPais),ocupa(OtroPais,OtroJugador,_)),
    OtroJugador \= Jugador.

esCaotico(Continente):-
    continente(Continente),
    findall(Jugador,estaEnContinente(Jugador,Continente),JugadoresEnContinente),
    length(JugadoresEnContinente,CantidadJugadores),
    CantidadJugadores > 3.

capoCannoniere(Jugador):-
    jugador(Jugador),
    cantidadPaises(Jugador,CantidadPaises1),
    cantidadPaises(OtroJugador,CantidadPaises2),
    CantidadPaises1 > CantidadPaises2,
    Jugador \= OtroJugador.

ganadooor(Jugador):-
    jugador(Jugador),
    objetivo(Jugador,Objetivo).

