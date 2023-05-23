% Saúl Sánchez Rangel - A01383954
-module(act6_1).
-export([prueba_suma/0, suma/0]).
-export([reg/0]).

prueba_suma() -> 
   P = spawn(act6_1, suma, []), 
   prueba_suma(5, P). 
prueba_suma(N, P) when N > 0 -> 
   P ! {suma, N, self()}, 
   receive 
       {respuesta, S} -> 
           io:format("Acumulado ~w~n", [S]), 
           prueba_suma(N-1, P) 
   end; 
prueba_suma(_, _) -> 
    io:format("Terminé mi trabajo~n").

% Implementar el proceso  act6_1:suma() que acepte un mensaje  {suma,N,P}, 
% donde P se  asume  que  es  un  pid.  Para  cada  mensaje,  el  proceso  debe mandar 
% {respuesta, S} a P (donde S es un acumulador).

suma() ->
    suma(0).

suma(S) ->
    receive
        {suma, N, P} ->
            Suma = S + N,
            P ! {respuesta, Suma},
            suma(Suma);
        _ ->
            suma(S)
         
    end.

%  Implementar el proceso act6_1:registro() que maneje los siguientes mensajes:  
% • {registra, Nombre} guarda Nombre en una lista si no está registrado. 
% • {elimina, Nombre} elimina el Nombre de la lista si está registrado 
% • {busca, Nombre, P} manda el mensaje {encontrado, E} al proceso 
% P. E debe ser el átomo si o no dependiendo de si Nombre está registrado. 
% • {lista, P} manda un mensaje de la forma {registrados, L} al 
% proceso P. L debe ser la lista de nombres registrados. 

reg() ->
    registro([]).

registro(L) ->
    receive
        {registra, Nombre} ->
            case lists:member(Nombre, L) of
                true ->
                    io:format("Ya está registrado ~w~n", [Nombre]),
                    registro(L);
                false ->
                    registro([Nombre | L])
            end;        {elimina, Nombre} ->
            registro(lists:delete(Nombre, L));
        {busca, Nombre, P} ->
            E = case lists:member(Nombre, L) of
                    true -> si;
                    false -> no
                end,
            P ! {encontrado, E},
            registro(L);
        {lista, P} ->
            P ! {registrados, L},
            registro(L);
        {termina, _} ->
            ok;
         _ ->
            registro(L)
    end.