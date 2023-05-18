-module(listas).
-export([cuenta/1, ceros/1, incrementa/1, cuenta_atomos/1, anida_nveces/1, anida_aux/2]).
-export([incrementa_li/1, ordena/1, inserta/2, suma_matrices/2, suma_renglon/2]).


cuenta([]) ->
    0;
cuenta([_|Resto]) ->
    1 + cuenta(Resto).

% regresa una lista con n ceros
% caso base (como clausula de guardia)
ceros(0) -> [];
% caso general
ceros(N) when N > 0 -> [0|ceros(N-1)].

% incrementa unitariamente todos los elementos de la lista
% caso base
incrementa([]) -> [];
% caso general
incrementa([Primero|Resto]) ->
    [Primero+1|incrementa(Resto)].

% cuenta la cantidad de átomos en una lista posiblemente anidada
% caso base
cuenta_atomos([]) -> 0;
% caso general
cuenta_atomos([Primero|Resto]) when not is_list(Primero) ->
    1 + cuenta_atomos(Resto);
cuenta_atomos([Lista | Resto]) when is_list(Lista) ->
    cuenta_atomos(Lista) + cuenta_atomos(Resto).

% generar una lista donde su único elemento "n" se encuentre anidado "n" veces
anida_nveces(N) -> anida_aux(N, N).
% caso base
anida_aux(N, 0) -> [N];
% caso general
anida_aux(N,M) -> [anida_aux(N,M-1)].

% incrementa los números de una lista posiblemente anidada
% caso base
incrementa_li([]) -> [];
% caso general
incrementa_li([N | Resto]) when is_number(N) ->
    [N+1 | incrementa_li(Resto)];
incrementa_li([L | Resto]) when is_list(L) ->
    [incrementa_li(L) | incrementa_li(Resto)];
incrementa_li([Otra|Resto]) -> 
    [Otra | incrementa_li(Resto)].

% ordena un arreglo de números
% caso base
ordena([]) -> [];
% caso general
ordena([N|Resto]) ->
    inserta(N, ordena(Resto)).

% inserta un número en una lista ordenada
% caso base
inserta(N, []) -> [N];
% caso general
inserta(N, [P | R]) when N =< P -> [N, P | R];
inserta(N, [P | R]) -> [P | inserta(N, R)].

% suma dos matrices ordenados por renglón
% caso base
suma_matrices([], []) -> [];
% caso general
suma_matrices([R1 | Resto1], [R2 | Resto2]) ->
    [suma_renglon(R1, R2) | suma_matrices(Resto1, Resto2)].

% suma dos renglones
% caso base
suma_renglon([], []) -> [];
% caso general
suma_renglon([N1 | Resto1], [N2 | Resto2]) ->
    [N1 + N2 | suma_renglon(Resto1, Resto2)].