 tarea(basico,buscar(libro,jartum)).
 tarea(basico,buscar(arbol,patras)).
 tarea(basico,buscar(roca,telaviv)).
 tarea(intermedio,buscar(arbol,sofia)).
 tarea(intermedio,buscar(arbol,bucarest)).
 tarea(avanzado,buscar(perro,bari)).
 tarea(avanzado,buscar(flor,belgrado)).

 nivelActual(pepe,basico).
 nivelActual(lucy,intermedio).
 nivelActual(juancho,avanzado).
 nivelActual(jamon,basico).

 idioma(alejandria,arabe).
 idioma(jartum,arabe).
 idioma(patras,griego).
 idioma(telaviv,hebreo).
 idioma(sofia,bulgaro).
 idioma(bari,italiano).
 idioma(bucarest,rumano).
 idioma(belgrado,serbio).

 habla(pepe,bulgaro).
 habla(pepe,griego).
 habla(pepe,italiano).
 habla(juancho,arabe).
 habla(juancho,griego).
 habla(juancho,hebreo).
 habla(lucy,griego).

 capital(pepe,1200).
 capital(lucy,3000).
 capital(juancho,500).
capital(jamon,1000000).


destinoPosible(Persona,Ciudad):-
    nivelActual(Persona,Nivel),
    tarea(Nivel,buscar(_,Ciudad)).

idiomaUtil(Persona,Idioma):-
    destinoPosible(Persona,Ciudad),
    idioma(Ciudad,Idioma).

excelenteCompaniero(Participante1,Participante2):-
    participante(Participante1),
    participante(Participante2),
    forall(idiomaUtil(Participante1,Idioma),habla(Participante2,Idioma)).

interesante(Nivel):-
    nivelActual(_,Nivel),
    forall(tarea(Nivel,buscar(Cosa,_)),estaVivo(Cosa)).
interesante(Nivel):-
    tarea(Nivel,buscar(_,Ciudad)),
    idioma(Ciudad,italiano).
interesante(Nivel):-
    nivelActual(Participante,Nivel),
    findall(Capitales,capital(Participante,Capitales),Capital),
    sumlist(Capital,CapitalTotal),
    CapitalTotal > 10000.


    estaVivo(arbol).
    estaVivo(perro).
    estaVivo(flor).

complicado(Participante):-
    participante(Participante),
    not(hablaIdiomasDestino(Participante)).

complicado(Participante):-
    participante(Participante),
    not(esBasico(Participante)),
    capitalMenor(Participante,1500).

complicado(Participante):-
    participante(Participante),
    esBasico(Participante),
    capitalMenor(Participante,500).

hablaIdiomasDestino(Participante):-
idiomaUtil(Participante,Idioma),
habla(Participante,Idioma).

esBasico(Participante):-
    nivelActual(Participante,basico).

capitalMenor(Participante,Monto):-
    capital(Participante,Capital),
    Capital < Monto.
participante(Participante):-
nivelActual(Participante,_).


homogeneo(Nivel):-
    nivelActual(_,Nivel),
    forall(tarea(Nivel,buscar(Cosa,_)),sonTodosIguales(Nivel,Cosa)).

sonTodosIguales(Nivel,Cosa):-
    forall(tarea(Nivel,buscar(Cosas,_)),member(Cosas,Cosa)).

poliglota(Persona):-
    participante(Persona),
    findall(Idioma,habla(Persona,Idioma),Idiomas),
    length(Idiomas,CantidadIdiomas),
    CantidadIdiomas >= 3.