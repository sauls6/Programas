% Sebastian Marines 
% Saul Sanchez
-module(act5_4).
-export([filtra/2]).
-export([mapea/2]).
-export([compon/2]).
-export([hay_pares/1]).
-export([impares/1]).
-export([empareja/1]).

% recibe una funcion booleana y lista de numeros; regresa la lista de los numeros que cumplen con la condicion booleana Pred
% caso base
filtra(_Pred, []) -> [];
% caso general
filtra(Pred, [H | T]) ->
    case Pred(H) of
        true -> [H | filtra(Pred, T)];
        false -> filtra(Pred, T)
    end.

% recibe una funcion unaria y lista de numeros; regresa la lista con los resultados de aplicar la funcion a cada elemento de la lista
% caso base
mapea(_, []) -> [];
% caso general
mapea(F, [H | T]) -> [F(H) | mapea(F, T)].

% recibe dos funciones unarias y regresa una funcion unaria que es la composicion de las dos funciones
compon(F, G) ->
    fun(X) -> F(G(X)) end.

% determine si hay enteros pares dentro de una lista de sublistas
hay_pares(Lista) ->
    [X || Sublista <- Lista, X <- Sublista, X rem 2 =:= 0] /= [].

% elimine los elementos que no sean impares de una lista de sublistas de enteros
% caso base
impares(Lista) ->
    [ [ X || X <- Sublista, X rem 2 =:= 1 ] || Sublista <- Lista ].

% recibe una lista de numeros y regresa una lista de tuplas con todas las combinaciones posibles de los elementos de la lista
empareja(Lista) ->
    [{X,Y} || X <- Lista, Y <- Lista].