-module(fos).
-export([aplica/3, suma/2, multiplica/2, menor/2]).
-export([tipo/1]).

aplica(Func, A, B) when is_function(Func) -> Func(A, B).

suma(N1, N2) -> N1 + N2.

resta(N1, N2) -> N1 - N2.

multiplica(N1, N2) -> N1 * N2.

divide(N1, N2) -> N1 / N2.

menor(N1, N2) -> N1 < N2.

tipo(N) ->
    case N of
        1 -> fun suma/2;
        2 -> fun resta/2;
        3 -> fun multiplica/2;
        4 -> fun divide/2
    end.

% > F = fos:tipo(2), F(2, 3).