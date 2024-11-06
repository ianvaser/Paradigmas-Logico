vuelo(arg845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(mh101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(dlh470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(aal1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).

vuelo(ble849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(npo556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(dsm3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).
%Punto 1
tiempoTotalVuelo(Vuelo,TiempoTotal):-
    vuelo(Vuelo,_,ListaDestinos),
    findall(Tiempo ,tiempoVuelo(ListaDestinos,Tiempo),TiempoRetrasos),
    sumlist(TiempoRetrasos, TiempoTotal).
    
    
tiempoVuelo(ListaDestinos,Tiempo):-    
member(Destino, ListaDestinos),
retrasos(Destino,Tiempo).

retrasos(tramo(Tiempo),Tiempo).
retrasos(escala(_,Tiempo),Tiempo). 

%Punto 2
% escalaAburrida/2 : Relaciona un vuelo con cada una de sus escalas aburridas; una escala es aburrida si hay que esperar mas de 3 horas.
    
escalaAburrida(Vuelo,Escala):-
    vuelo(Vuelo,_,ListaDestinos),
    member(escala(Escala,Tiempo),ListaDestinos),
    Tiempo > 3.

%Punto 3
%ciudadesAburridas/2 : Relaciona un vuelo con la lista de ciudades de sus escalas aburridas.

ciudadesAburridas(Vuelo,ListaCiudadesAburridas):-
    findall(UnaEscala,escalaAburrida(Vuelo,UnaEscala),ListaCiudadesAburridas).

%Punto 4
%Si un vuelo pasa 10 o más horas en el aire,
%entonces es un vuelo largo. OJO que dice "en el aire", en este punto no hay que contar las esperas en tierra. conectados/2: Relaciona 2 vuelos si tienen al menos una ciudad en común.

vueloLargo(Vuelo):-
    vuelo(Vuelo,_,ListaDestinos),
    findall(Tramo,member(tramo(Tramo),ListaDestinos),ListaTramos),
    sumlist(ListaTramos, TiempoTotal),
    TiempoTotal >= 10 . 

bandaDeTres(Vuelo1,Vuelo2,Vuelo3):-
    vuelo(Vuelo1,_,_),
    vuelo(Vuelo2,_,_),
    vuelo(Vuelo3,_,_),
    Vuelo1 \= Vuelo2,
    Vuelo2 \= Vuelo3,
    conectados(Vuelo1,Vuelo2),
    conectados(Vuelo2,Vuelo3).

conectados(Vuelo1,Vuelo2):-
    vuelo(Vuelo1,_,ListaDestinosVuelo1),
    vuelo(Vuelo2,_,ListaDestinosVuelo2),
    member(escala(DestinoEnComun,_),ListaDestinosVuelo1),
    member(escala(DestinoEnComun,_),ListaDestinosVuelo2).

%Punto 6
%Relaciona dos ciudades que son escalas del mismo vuelo y la cantidad de escalas entre las mismas; si no hay escalas intermedias la distancia es 1. P.ej. París y Berlín están a distancia 1 (por el vuelo BLE849), Berlín y Seúl están a distancia 3 (por el mismo vuelo). No importa de qué vuelo, lo que tiene que pasar es que haya algún vuelo que tenga como escalas a ambas ciudades. Consejo: usar nth1.

distanciaEnEscalas(Ciudad1,Ciudad2,Distancia):-
    escala(Ciudad1,Vuelo),
    escala(Ciudad2,Vuelo),
    findall(Escala,escala(Escala,Vuelo),ListaCiudades),
    nth1(PosicionCiudad1,ListaCiudades,Ciudad1),
    nth1(PosicionCiudad2,ListaCiudades,Ciudad2),
    Distancia is abs(PosicionCiudad1 - PosicionCiudad2).

escala(Escala,Vuelo):-
    vuelo(Vuelo,_,ListaDestinos),
    member(escala(Escala,_),ListaDestinos).
%punto 7 

vueloLento(Vuelo):-
    vuelo(Vuelo,_,_),
    not(vueloLargo(Vuelo)),
    forall(escala(Escala,Vuelo), escalaAburrida(Vuelo,Escala)).

    