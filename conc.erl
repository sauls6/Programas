-module(conc).
-export([inicio/0, di_algo/2, areas/0]).
-export([prueba_hola/0]).
-export([calcula/0, prueba_calcula/0]).
-export([iniciopingpong/0, ping/2, pong/0]).


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
            io:format("Area del rectangulo = ~p~n", [Anchura * Altura]),
            areas();
        {circulo, R} ->
            io:format("Area del circulo = ~p~n", [3.14159 * R * R]),
            areas();
        termina ->
            io:format("Termine de ejecutarme~n");
        Otro ->
            io:format("Desconozco el area del ~p ~n", [Otro]),
            areas()
    end.

prueba_hola() ->
    H = spawn(?MODULE, hola, []),
    prueba_hola(10, H).
prueba_hola(N, H) when N > 0 ->
    H ! {hola, self()},
    receive
        {reply, C} ->
            io:format("Recibido ~w~n", [C]),
            prueba_hola(N - 1, H)
    end;
prueba_hola(_, _) ->
    io:format("Mi trabajo está hecho~n").

% wrapper de calcula/2
calcula() -> calcula(-1, 0).

calcula(L, S) ->
    receive
        {suma, X, Y} ->
            NewL = X + Y,
            calcula(NewL, S + NewL);
        {multiplica, X, Y} ->
            NewL = X * Y,
            calcula(NewL, S + NewL);
        {ultimo, PID} ->
            PID ! {resultado, L},
            calcula(L, S);
        {total, PID} ->
            PID ! {resultado, S},
            calcula(L, S);
        termina ->
            bye
    end.

recibe() ->
    receive
        {resultado, L} ->
            io:format("Resultado - ~w~n", [L])
    end.

prueba_calcula() ->
    PID = spawn(fun calcula/0),
    M = self(),
    PID ! {ultimo, M},
    receive
        {resultado, L} ->
            io:format("Resultado - ~w~n", [L])
    end,
    PID ! {suma, 3, 7},
    PID ! {multiplica, 4, 8},
    PID ! {ultimo, M},
    recibe(),
    PID ! {suma, 20, 38},
    PID ! {total, M},
    recibe(),
    PID ! termina.


ping(0, Pong_PID) ->
    Pong_PID ! terminado,
    io:format("Ping termino~n", []);
ping(N, Pong_PID) ->
    Pong_PID ! {ping, self()},
    receive
        pong -> io:format("Ping recibe pong~n", [])
    end,
    ping(N - 1, Pong_PID).
pong() ->
    receive
        terminado ->
            io:format("Pong termino~n", []);
        {ping, Ping_PID} ->
            io:format("Pong recibio ping~n", []),
            Ping_PID ! pong,
            pong()
    end.
iniciopingpong() ->
    Pong_PID = spawn(conc, pong, []),
    spawn(conc, ping, [3, Pong_PID]).
