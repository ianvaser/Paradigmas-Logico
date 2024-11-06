linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

%%%Punto 1 
estaEn(Linea,Estacion):-
    linea(Linea,Estaciones),
    member(Estacion,Estaciones).
%%%%Punto 2%%%%
distancia(EstacionA,EstacionB,Distancia):-
    posicionEstacion(EstacionA,PosicionEstacionA),
    posicionEstacion(EstacionB,PosicionEstacionB),
    Distancia is abs(PosicionEstacionA - PosicionEstacionB).

posicionEstacion(Estacion,PosicionEstacion):-
    estaEn(Linea,Estacion),
    linea(Linea,EstacionesLinea),
    nth0(PosicionEstacion, EstacionesLinea ,Estacion).
%%%%%%%Punto3%%%%%%%%%%%%%%%%%%%
mismaAltura(EstacionA,EstacionB):-
    posicionEstacion(EstacionA,PosicionEstacionA),
    posicionEstacion(EstacionB,PosicionEstacionB),
    PosicionEstacionA == PosicionEstacionB.
%%%%%%Punto4%%%%%%%%%%%%%%%
viajeFacil(EstacionA,EstacionB):-
    estaEn(LineaA,EstacionA),
    estaEn(LineaB,EstacionB),
    LineaA == LineaB.
viajeFacil(EstacionA,EstacionB):-
    estaEn(LineaA,EstacionA),
    estaEn(LineaB,EstacionB),
    combinacion(Combinaciones),
    member(UnaEstacion, Combinaciones),
    member(UnaEstacion, Estaciones1).
    
