-module(es_triangulo/3)
-export([triangulo/3]).

es_triangulo(A, B, C) ->
    A + B > C andalso A + C > B andalso B + C > A.

triangulo(A, B, C) when is_integer(A), is_integer(B), is_integer(C) ->
    T = es_triangulo(A, B, C),
    if
        not T -> no_triangulo;
        (A == B) and (B == C) -> equilatero;
        (A == B) or (A == C) or (B == C) -> isosceles;
        true -> escaleno
    end.