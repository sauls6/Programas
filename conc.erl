-module(conc).
-export(inicio/0, di_algo/2).

di_algo(_, 0) ->
    hecho;
di_algo(Que, Veces) ->
    io:format("Que: ~p~n", [Que]),
    di_algo(Que, Veces - 1).

inicio() ->
    spawn(conc, di_algo, [hola, 3]),
    spawn(conc, di_algo, [adios, 3]),
    spawn(conc, di_algo, [bye, 3]).