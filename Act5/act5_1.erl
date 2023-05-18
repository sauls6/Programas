-module(act5_1).
-export([mayor/3, clima/1, cuadrante/2, sumapar/4]).

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