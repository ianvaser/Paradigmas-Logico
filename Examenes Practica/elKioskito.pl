atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes ,9,15).
atiende(lucas,martes,10,20).
atiende(juanC,sabados,18,22).
atiende(juanC,domingos,18,22).
atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).
atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).
atiende(martu,miercoles,23,24).
atiende(maiu,martes,0,8).
atiende(maiu,miercoles,0,8).

atiende(vale,Horario):-
    atiende(dodain,Horario).
atiende(vale,Horario):-
    atiende(juanC,Horario).

atiende(Profe):-
    Profe \= leoC,
    atiende(Profe,Horario),
    not(atiende(leoC,Horario)).


quienAtiende(Dia,Horario,Profe):-
    atiende(Profe,Dia,InicioHorario,FinHorario),
    atiendeEn(Horario,InicioHorario,FinHorario).

atiendeEn(Horario,PrimeraHora,UltimaHora):-
    Horario >= PrimeraHora,
    Horario =< UltimaHora.

foreverAlone(Dia,Horario,Profe):-
    profe(Profe),
    profe(OtroProfe),
    quienAtiende(Dia,Horario,Profe),
    not(quienAtiende(Dia,Horario,OtroProfe)),
    Profe \= OtroProfe.

profe(Profe):-
    atiende(Profe,_,_,_).

posibilidadAtencion(Dia,Profe):-
    atiende(Profe,Dia,_,_).

