-module(conc).
-export([inicio/0, di_algo/2, areas/0]).

di_algo(_, 0) ->
	hecho;
di_algo(Que, Veces) ->
	io:format("~p~n", [Que]),
	di_algo(Que, Veces - 1).

inicio() ->
	spawn(conc, di_algo, [hola, 3]),
	spawn(conc, di_algo, [adios, 3]),
    spawn(conc, di_algo, [bye, 3]).
    
areas() ->
  receive
    {rectangulo, Anchura, Altura} ->
	io:format("Area del rectangulo = ~p~n" ,[Anchura * Altura]),
	areas();
    {circulo, R} ->
	io:format("Area del circulo = ~p~n" , [3.14159 * R * R]),
	areas();
    termina -> 
        io:format("Termine de ejecutarme~n");
    Otro ->
	io:format("Desconozco el area del ~p ~n" ,[Otro]),
	areas()
  end.