% Saúl Sánchez Rangel - A01383954
% Sebastian Marines Álvarez - A01383056

-module(act5_2).
-export([armonica/1, armonica_aux/1]).
-export([baja_sube/1, baja_sube_aux/1]).
-export([fibo/1, fibo_aux/1]).
-export([fibot/1, fibot_aux/3]).
-export([count_ways/1, count_ways_aux/1]).

% recibe un numero N y regresa la suma de la serie armonica 1 + 1/2 + 1/3 + ... + 1/N
armonica(N) when is_integer(N) ->
    io:format("~.7f", [armonica_aux(N)]).
% caso base
armonica_aux(0) -> 0;
% caso general
armonica_aux(N) ->
    1/N + armonica_aux(N-1).

% despliega los numeros enteros del N al 1 y del 1 al N donde N > 0 separados por espacios
baja_sube(N) when is_integer(N) ->
    baja_sube_aux(N).
% caso base
baja_sube_aux(1) ->
    io:format("1 1");
% caso general
baja_sube_aux(N) ->
    io:format("~w ", [N]),
    baja_sube_aux(N-1),
    io:format(" ~w", [N]).

% regresa el n-esimo numero de la serie de fibonacci
fibo(N) when is_integer(N) ->
    fibo_aux(N).

fibo_aux(0) -> 0;
fibo_aux(1) -> 1;
fibo_aux(N) ->
    fibo_aux(N-1) + fibo_aux(N-2).

% fibonacci terminal
fibot(N) when is_integer(N) ->
    fibot_aux(N, 0, 1).

fibot_aux(0, A, _) ->
    A;
fibot_aux(1, _, B) ->
    B;
fibot_aux(N, A, B) ->
    fibot_aux(N-1, B, A+B).

count_ways(N) when is_integer(N) ->
    count_ways_aux(N).

count_ways_aux(0) -> 1;
count_ways_aux(1) -> 1;
count_ways_aux(N) ->
    count_ways_aux(N-1) + count_ways_aux(N-2).