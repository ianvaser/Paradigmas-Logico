mago(harry,mestizo,[coraje,amistoso,orgulloso],slytherin).
mago(draco,puro,[inteligente,orgulloso],hufflepuff).
mago(hermione,impuro,[inteligente,orgulloso,responsable],_).
mago(panio,puri,[amistoso,coraje,responsable],slytherin).

casa(gryffindor,coraje).
casa(slytherin,orgulloso).
casa(slytherin,inteligente).
casa(ravenclaw,inteligente).
casa(ravenclaw,responsable).
casa(hufflepuff,amistoso).



dejaEntrar(slytherin,Mago):-
    not(mago(Mago,impuro,_,_)).

dejaEntrar(Mago,Casa):-
    casa(Casa,_),
    Casa \= slytherin,
    mago(Mago,_,_,_).

caracterApropiado(Mago,Casa):-
    mago(Mago,_,CaracteristicasMago,_),
    casa(Casa,_),
    forall(casa(Casa,CaracteristicasCasa),member(CaracteristicasCasa,CaracteristicasMago)).

seleccionado(Mago,Casa):-
    casa(Casa,_),
    caracterApropiado(Mago,Casa),
    dejaEntrar(Mago,Casa),
    not(odiaCasa(Mago,Casa)).
seleccionado(hermione,gryffindor).

odiaCasa(Mago,Casa):-
    mago(Mago,_,_,CasaOdiada),
    Casa = CasaOdiada.

cadenaDeAmistades(ListaDeMagos):-
    forall(member(Mago,ListaDeMagos),esAmistoso(Mago)),
    estaEnLaCasaDelSiguiente(ListaDeMagos).

esAmistoso(Mago):-
    mago(Mago,_,Caracteristicas,_),
    member(amistoso,Caracteristicas).

estaEnLaCasaDelSiguiente(ListaDeMagos):-
    member(Mago1,ListaDeMagos),
    member(Mago2,ListaDeMagos),
    Mago1 \= Mago2,
    seleccionado(Mago1,Casa),
    seleccionado(Mago2,Casa).
    
puntos(mala,fueraDeCama,50).
puntos(mala,bosque,50).
puntos(mala,biblioteca,10).
puntos(mala,tercerPiso,75).
puntos(buena,ganarAjedrez,50).
puntos(buena,salvarAmigos,50).
puntos(buena,ganarAVoldemort,60).
puntos(mala,mazmorra,10).
puntos(buena,responderPregunta,pregunta(Pregunta,Dificultad,Profesor)).

acciones(harry,fueraDeCama).
acciones(hermione,tercerPiso).
acciones(hermione,biblioteca).
acciones(harry,bosque).
acciones(harry,tercerPiso).
acciones(draco,mazmorra).
acciones(ron,ganarAjedrez).
acciones(hermione,salvarAmigos).
acciones(harry,ganarAVoldemort).
acciones(luna,salvarAmigos).

esDe(hermione, gryffindor).

esDe(ron, gryffindor).

esDe(harry, gryffindor).

esDe(draco, slytherin).

esDe(luna, ravenclaw).

esBuenAlumno(Mago):-
    mago(Mago),
    forall(acciones(Mago,Acciones),puntos(buena,Acciones,_)).

mago(Mago):-
    acciones(Mago,_).

recurrente(Accion):-
    acciones(Mago,Accion),
    acciones(OtroMago,Accion),
    Mago \= OtroMago.

puntajeTotalCasa(Casa,PuntajeTotalCasa):-
    esDe(_,Casa),
    findall(Puntaje,puntajeDeCadaMago(Casa,Puntaje),ListaPuntajes),
    sumlist(ListaPuntajes,PuntajeTotalCasa).

puntajeDeCadaMago(Casa,PuntajeTotal):-
    esDe(Mago,Casa),
    findall(Puntos,puntosBuenos(Mago,Puntos),PuntosPositivos),
    findall(Puntos,puntosMalos(Mago,Puntos),PuntosNegativos),
    sumlist(PuntosPositivos,PuntosAFavor),
    sumlist(PuntosNegativos,PuntosEnContra),
    PuntajeTotal is (PuntosAFavor - PuntosEnContra).
    
puntosBuenos(Mago,Puntos):-
acciones(Mago,Accion),
puntos(buena,Accion,Puntos).

puntosMalos(Mago,Puntos):-
    acciones(Mago,Accion),
    puntos(mala,Accion,Puntos).

casaGanadora(Casa):-
    puntajeTotalCasa(Casa,PuntosCasaMayor),
    forall((puntajeTotalCasa(OtraCasa,Puntos),Casa \= OtraCasa),(Puntos < PuntosCasaMayor)).
