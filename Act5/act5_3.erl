-module(act5_3).
-export([palindromo/1]).
-export([profundidad/1]).
-export([elimina/2]).
-export([agrega_valor/3]).
-export([cuenta_nivel/2]).
-export([elimina_nodo/2]).

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

% Programar la función recursiva agrega_valor(V, P, M) que agregue el nuevo 
% valor V a una matriz M dada en la posición P= [renglón, columna] especificada, 
% de la siguiente forma: si la matriz ya tiene un valor en esa posición, que lo 
% sustituya por el valor a agregar, pero si la matriz no tiene el número de 
% renglones y/o columnas necesarias para colocar el nuevo valor, que agregue los 
% renglones y/o columnas mínimas necesarias para agregar el valor.
agrega_valor(V, [P_r, P_c], [H, T]) when P_c > length(H) andalso P_r > length([H, T]) ->
    agrega_valor(V, [P_r, P_c], [H, T, []]);
agrega_valor(V, [P_r, P_c], [H, T]) when P_c > length(H) ->
    agrega_valor(V, [P_r, P_c], [H, T, [] | []]);
agrega_valor(V, [P_r, P_c], [H, T]) when P_r > length([H, T]) ->
    agrega_valor(V, [P_r, P_c], [H, T | []]);
agrega_valor(V, [P_r, P_c], [H, T]) ->
    agrega_valor(V, [P_r, P_c], [H, T, [] | []]);
agrega_valor(V, [P_r, P_c], [H | T]) when P_r == 1 ->
    [agrega_valor_renglon(V, P_c, H) | T];
agrega_valor(V, [P_r, P_c], [H | T]) ->
    [H | agrega_valor(V, [P_r - 1, P_c], T)].

agrega_valor_renglon(V, P_c, [_ | T]) when P_c == 1 ->
    [V | T];
agrega_valor_renglon(V, P_c, [H | T]) ->
    [H | agrega_valor_renglon(V, P_c - 1, T)].

% Programar la función cuenta_nivel(Nivel,Arbol) que regrese la cantidad de 
% nodos en cierto nivel de un árbol binario. La raíz se encuentra en el nivel 0. 
cuenta_nivel(Nivel, Arbol) ->
    cuenta_nivel_aux(Nivel, Arbol, 0).

cuenta_nivel_aux(_, nil, _) ->
    0;

cuenta_nivel_aux(Nivel, {_, Izq, Der}, Now) ->
    if Now =:= Nivel ->
        1 + cuenta_nivel_aux(Nivel, Izq, Now+1) + cuenta_nivel_aux(Nivel, Der, Now+1);
    true ->
        cuenta_nivel_aux(Nivel, Izq, Now+1) + cuenta_nivel_aux(Nivel, Der, Now+1)
    end.

% Implementar la función elimina_nodo(Grafo,Nodo) que recibe como 
% argumentos un grafo y el nombre de un nodo, y regresa el grafo sin el nodo 
% especificado (si existe). Como se puede ver en los ejemplos, también elimina los 
% arcos dirigidos al nodo eliminado.
elimina_nodo(Grafo, Nodo) ->
    elimina_nodo(Grafo, Nodo, []).
elimina_nodo([], _, Acum) ->
    Acum;
elimina_nodo([H | T], Nodo, Acum) ->
    elimina_nodo(T, Nodo, [elimina_nodo_nodo(H, Nodo) | Acum]).
elimina_nodo_nodo([H | T], Nodo) when is_atom(H) ->
    [H | elimina_nodo_nodo(T, Nodo)];
elimina_nodo_nodo([H | T], Nodo) when H == Nodo ->
    elimina_nodo_nodo(T, Nodo);
elimina_nodo_nodo([H | T], Nodo) ->
    [H | elimina_nodo_nodo(T, Nodo)].