/*Saltos*/
puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).
/*Qué puntaje obtuvo un competidor en un salto, p.ej. qué puntaje obtuvo Hernán en el salto 4 (respuesta: 6).*/
puntajexSalto(Competidor,Salto,Puntaje):-
    puntajes(Competidor,ListaPuntajes),
    nth1(Salto,ListaPuntajes,Puntaje).
/*Si un competidor está descalificado o no. Un competidor está descalificado si hizo más de 5 saltos. En el ejemplo, Julio está descalificado.*/
descalificado(Competidor):-
    puntajexSalto(Competidor,6,HizoMaxSalto),
    HizoMaxSalto > 0.
/*Si un competidor clasifica a la final. Un competidor clasifica a la final si la suma de sus puntajes es mayor o igual a 28, o si tiene dos saltos de 8 o más puntos.*/
clasificadoFinal(Competidor):-
    not(descalificado(Competidor)),
    puntajes(Competidor,ListaPuntajes),
    sum_list(ListaPuntajes, SumaPuntajes),
    SumaPuntajes > 27.
clasificadoFinal(Competidor):-
    puntajes(Competidor,_),
    findall(X,esMayor(Competidor,X),ListaMayores),
    length(ListaMayores, CantidadMayores),
    CantidadMayores == 2.

esMayor(Competidor,ListaMayores):-
    puntajes(Competidor,ListaPuntajes),
    member(Puntajes,ListaPuntajes),
    Puntajes > 7,
    ListaMayores = Puntajes.
    