jockey(valdivieso,155,52).
jockey(leguisamo,161,49).
jockey(lezcano,149,50).
jockey(baratucci,153,55).
jockey(falero,157,52).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

preferencia(botafogo,Jockey):-
    preferenciasBotafogo(Jockey).
preferencia(oldMan,Jockey):-
    jockey(Jockey),
    atom_length(Jockey, LetrasNombre),
    LetrasNombre > 7.
preferencia(energica,Jockey):-
    jockey(Jockey),
    not(preferencia(botafogo,Jockey)).
preferencia(matBoy,Jockey):-
    jockey(Jockey,Altura,_),
    Altura >170.

    preferenciasBotafogo(botafogo,baratucci).
preferenciasBotafogo(Jockey):-
    jockey(Jockey,_,Peso),
    Peso < 52.

jockey(Jockey):-
    jockey(Jockey,_,_).

stud(valdivieso,elTute).
stud(falero,elTute).
stud(lezcano,lasHormigas).
stud(baratucci,elCharabon).
stud(leguisamo,elCharabon).

premio(botafogo,granPremioNacional).
premio(botafogo,granPremioRepublica).
premio(oldMan,granPremioRepublica).
premio(oldMan,campeonatoPalermoOro).
premio(matBoy,granPremioCriadores).

% Punto 2%

masDeUnJockey(Caballo):-
    caballo(Caballo),
    preferencia(Caballo,Jockey),
    preferencia(Caballo,OtroJockey),
    OtroJockey \= Jockey.

% Punto 3
aborrece(Caballo,Caballeriza):-
    caballo(Caballo),
    stud(_,Caballeriza),
    forall(preferencia(Caballo,Jockey),not(stud(Jockey,Caballeriza))).

% Punto 4

piolines(Jockey):-
    jockey(Jockey),
    forall(ganoAlgoImportante(Caballo),preferencia(Caballo,Jockey)).

ganoAlgoImportante(Caballo):-
    premio(Caballo,granPremioNacional).
ganoAlgoImportante(Caballo):-
    premio(Caballo,granPremioRepublica).

% Punto 5
resultado(botafogo,primero).
resultado(oldMan,segundo).
resultado(energica,tercero).
resultado(matBoy,cuarto).
resultado(yatasto,quinto).

elJugador(ganador(Caballo),Resultado):- 
    resultado(Caballo,Resultado),
    Resultado = primero.
elJugador(segundo(Caballo),Resultado):- 
    resultado(Caballo,Resultado),
    Resultado = segundo.
elJugador(segundo(Caballo),Resultado):-
    elJugador(ganador(Caballo),Resultado).
elJugador(exacta(Caballo,OtroCaballo),Resultado):-
    elJugador(ganador(Caballo),Resultado),
    elJugador(segundo(OtroCaballo),Resultado),
    Caballo \= OtroCaballo.
elJugador(imperfecta(Caballo,OtroCaballo),Resultado):-
    elJugador(exacta(Caballo,OtroCaballo),Resultado).
elJugador(imperfecta(Caballo,OtroCaballo),Resultado):- 
    elJugador(ganador(OtroCaballo),Resultado),
    elJugador(segundo(Caballo),Resultado).

% Punto 6 
raza(botafogo,tordo).
raza(oldMan,alazan).
raza(energica,ratonero).
raza(matBoy,palomino).
raza(yatasto,pinto).

colorCrin(tordo,negro).
colorCrin(alazan,marron).
colorCrin(ratonero,gris).
colorCrin(ratonero,negro).
colorCrin(palomino,marron).
colorCrin(palomino,blanco).
colorCrin(pinto,blanco).
colorCrin(pinto,marron).

caballoColor(PreferenciaColor,Caballos):-
    findall(Caballo,buscarPorColor(PreferenciaColor,Caballo),Caballos).

buscarPorColor(PreferenciaColor,Caballo):-
    colorCrin(Raza,PreferenciaColor),
    raza(Caballo,Raza).

