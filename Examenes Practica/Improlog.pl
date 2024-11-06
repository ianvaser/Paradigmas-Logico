integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi,
  guitarra).
integrante(jazzmin, santi, bateria).
integrante(jazzmin, japito, bajo).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).

nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

buenaBase(Banda):-
    queTipoInstrumentoToca(Banda,ritmico),
    queTipoInstrumentoToca(Banda,armonico).
    

queTipoInstrumentoToca(Banda,Tipo):-
    integrante(Banda,_,Instrumento),
    instrumento(Instrumento,Tipo).

seDestaca(Integrante):-
    Integrante  \= Destacado,
    integrante(Banda,Destacado,_),
    forall((integrante(Banda,Integrante,_)),(esMas(Integrante,Destacado))).

esMas(Integrante,Destacado):-
    nivelQueTiene(Destacado,_,Nivel1),
    nivelQueTiene(Integrante,_,Nivel2),
    (Nivel1 - Nivel2 )> 2.