-module(act5_3).
-export([mayor/3, clima/1, cuadrante/2, sumapar/4]).

-export([armonica/1, armonica_aux/1]).
-export([baja_sube/1, baja_sube_aux/1]).
-export([fibo/1, fibo_aux/1]).
-export([fibot/1, fibot_aux/3]).
-export([count_ways/1, count_ways_aux/1]).
-export([palindromo/1]).
-export([profundidad/1]).
-export([elimina/2]).
-export([agrega_valor/3, agregar_valor/4]).
-export([agregar_filas/4, agregar_valor_fila/3, agregar_valor_col/4]).

% recibe 3 argumentos numéricos y regresa el mayor de ellos
mayor(X,Y,Z) when is_integer(X), is_integer(Y), is_integer(Z) ->
    Max = X,
    Max = if Max < Y -> Y; true -> Max end,
    Max = if Max < Z -> Z; true -> Max end,
    Max.

% recibe un número que representa la temperatura en centigrados y regrese un simbolo de acuerdo
% con el valor de temperatura y los criterios descrritos a continuación:
% Temp <= 0 -> congelado
% 0 < Temp <= 10 -> helado
% 10 < Temp <= 20 -> frio
% 20 < Temp <= 30 -> normal
% 30 < Temp <= 40 -> caliente
% 40 < Temp -> hirviendo

clima(T) when is_integer(T) ->
    if
        T =< 0 -> congelado;
        T =< 10 -> helado;
        T =< 20 -> frio;
        T =< 30 -> normal;
        T =< 40 -> caliente;
        true -> hirviendo
    end.

% recibe dos números que representan las coordenadas de un punto en el plano cartesiano y regresa
% un simbolo de acuerdo con el cuadrante en el que se encuentra el punto y los criterios descritos
cuadrante(0, 0) -> 'Origen';
cuadrante(0, _) -> 'Eje Y';
cuadrante(_, 0) -> 'Eje X';
cuadrante(X, Y) when is_integer(X), is_integer(Y) ->
    if
        X > 0, Y > 0 -> 'Primer cuadrante';
        X < 0, Y > 0 -> 'Segundo cuadrante';
        X < 0, Y < 0 -> 'Tercer cuadrante';
        X > 0, Y < 0 -> 'Cuarto cuadrante'
    end.

sumapar(Num1, Num2, Num3, Num4) when is_integer(Num1), is_integer(Num2), is_integer(Num3), is_integer(Num4) ->
    if Num1 rem 2 == 0 -> Num1; true -> 0 end +
    if Num2 rem 2 == 0 -> Num2; true -> 0 end +
    if Num3 rem 2 == 0 -> Num3; true -> 0 end +
    if Num4 rem 2 == 0 -> Num4; true -> 0 end.

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

% Programar  la  función  recursiva  palíndromo(N)  que  regresa  una  lista  que 
% represente un palíndromo que resulta de anidar los números enteros de 0 a N.
% Ejemplo: palíndromo(3) -> [0,1,2,3,3,2,1,0]
palindromo(N) when is_integer(N), N >= 0 ->
    List = palindromo_aux(N, []),
    List ++ lists:reverse(List).

palindromo_aux(0, List) -> [0|List];
palindromo_aux(N, List) -> palindromo_aux(N-1, [N|List]).

% Programar la función recursiva profundidad(Lista) que determine y regrese el 
% nivel máximo de anidación dentro de una lista posiblemente imbricada.
% Ejemplo: profundidad([1,2,3]) -> 1
profundidad([]) -> 0;
profundidad([Head | Tail]) when is_list(Head) ->
    Prof1 = 1 + profundidad(Head),
    Prof2 = profundidad(Tail),
    if Prof1 > Prof2 -> Prof1;
       true -> Prof2
    end;
profundidad([_ | Tail]) ->
    profundidad(Tail).

% Programar la función recursiva elimina(Dato, Lista) que reduzca una lista 
% posiblemente imbricada eliminando todos los elementos que coincidan con un 
% dato especificado por su primer argumento.
% Ejemplo: elimina(1, [1,2,3]) -> [2,3]
elimina(_, []) -> [];
elimina(Dato, [Dato | Tail]) ->
    elimina(Dato, Tail);
elimina(Dato, [Head | Tail]) when is_list(Head) ->
    [elimina(Dato, Head) | elimina(Dato, Tail)];
elimina(Dato, [Head | Tail]) ->
    [Head | elimina(Dato, Tail)].

    % agrega_valor(V, [I, J], M) ->
    %     agrega_valor_aux(V, I, J, M).

    % agrega_valor_aux(V, 0, J, [H | T]) ->
    %     [agrega_valor_fila(V, J, H) | T];
    % agrega_valor_aux(V, I, J, [H | T]) ->
    %     [H | agrega_valor_aux(V, I-1, J, T)].

% agrega_valor_fila(V, 0, [_ | T]) ->
%     [V | T];
% agrega_valor_fila(V, J, [H | T]) ->
%     [H | agrega_valor_fila(V, J-1, T)].

agrega_valor(V, [I, J], M) ->
    Rows = length(M),
    Cols = length(lists:nth(1, M)),
    M2 = agregar_filas(Rows, I, Cols, M),
    agregar_valor(V, I, J, M2).

% Agrega filas vacías a la matriz si se requiere
agregar_filas(Rows, I, Cols, M) when I > Rows ->
    agregar_filas(Rows + 1, I, Cols, M ++ [list_to_tuple(lists:duplicate(Cols, 0))]);
agregar_filas(_, _, _, M) -> M.

% Agrega el valor a la posición indicada
agregar_valor(V, I, J, M) ->
    [agregar_valor_fila(V, J, lists:nth(I, M)) | lists:sublist(M, I-1) ++ lists:nthtail(I, M)].

% Agrega el valor a la fila indicada
agregar_valor_fila(V, J, Row) ->
    [agregar_valor_col(V, J, lists:seq(1, length(Row)), Row)].

% Agrega el valor a la columna indicada
agregar_valor_col(V, J, [J | Tail], [_ | Tail2]) ->
    [V | agregar_valor_col(V, J-1, Tail, Tail2)];
agregar_valor_col(V, J, [_ | Tail], [H | Tail2]) ->
    [H | agregar_valor_col(V, J, Tail, Tail2)];
agregar_valor_col(_, _, [], []) -> [].