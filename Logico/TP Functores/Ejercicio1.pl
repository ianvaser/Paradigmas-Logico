canierias(codos(color)).
canierias(canios(color,longuitud)).
canierias(canillas(tipo,color,ancho)).
codos(rojo).
canios(rojo,3).
canillas(rectangular,rojo,6).
precio(codos,3).
precio(canios,5).
precio(canillas,[20,12,5]).

/*Ejercicio1*/
consultarPrecio(codos,Precio):-precio(codos,Precio).
consultarPrecio(canios,Precio):-
    canios(_,Metros),
    precio(canios,Valor),
    Precio is Valor*Metros.
consultarPrecio(canillas,Precio):-
    canillas(triangular,_,_),
    precio(canillas,[Precio,_,_]).
consultarPrecio(canillas,Precio):-
    esMenor5Cm(),
    precio(canillas,[_,Precio,_]).
consultarPrecio(canillas,Precio):-
    esMayor5Cm(),
    precio(canillas,[_,_,Precio]).


esMenor5Cm():-
    not(canillas(triangular,_,_)),
    canillas(_,_,CentiMetros),
    CentiMetros < 6.
esMayor5Cm():-
    not(canillas(triangular,_,_)),
    canillas(_,_,CentiMetros),
    CentiMetros > 5.
/*Ejercicio2*/
