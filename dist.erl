%% EJERCICIO DE CLASE # 17

-module(dist).
-export([inicio/0, crea_eslavo/1, para_eslavo/2, termina/0,
         maestro/0, eslavo/1]).

% CÓDIGO PARA EL MAESTRO

% proceso del maestro
maestro() ->
   process_flag(trap_exit, true),
   maestro(1, []).
% maestro recuerda el número del siguiente eslavo
% a crearse y la lista de eslavos existentes
maestro(N, Eslavos) ->
   receive
      {crea_eslavo, NNodo} ->
		 Nodo = nodo(NNodo),
	     monitor_node(Nodo, true),
         Pid = spawn(Nodo, dist, eslavo, [N]),
		 receive
		    {nodedown, Nodo} -> 
			   io:format("nodo ~w no existe~n", [NNodo]),
			   maestro(N, Eslavos)
			after 0 -> 
			   io:format("eslavo ~w creado en nodo ~w~n",
			             [N, NNodo]),
			   monitor_node(Nodo, false),
			   maestro(N+1, Eslavos++[{N, Pid}])
	     end;
	  {De, {mensaje, Mensaje, Neslavo}} ->
	     case busca(Neslavo, Eslavos) of
		    inexistente ->
			   De ! inexistente;
			Epid ->
			   Epid ! {mensaje, Mensaje},
			   De ! enviado
		 end,
		 maestro(N, Eslavos); 
	  {'EXIT', PID, _} -> 
		 maestro(N, elimina(PID, Eslavos));
      termina -> 
	     lists:map(fun({_, Epid}) -> 
		              Epid ! {mensaje, morir} end,
		           Eslavos)
   end.
   
% funciones auxiliares

% busca un nombre dentro de la lista de usuarios
busca(_, []) -> inexistente;
busca(N, [{N, PID}|_]) -> PID;
busca(N, [_|Resto]) -> busca(N, Resto).

% elimina el eslavo con determinado PID
elimina(_, []) -> [];
elimina(PID, [{_, PID}|Resto]) -> Resto;
elimina(PID, [Eslavo|Resto]) -> [Eslavo|elimina(PID, Resto)].

% FUNCIONES DE INTERFAZ DE USUARIO

% crea y registra el proceso del maestro con el alias "maestro"
inicio() ->
   register(maestro, spawn(dist, maestro, [])),
   'maestro creado'.
   
% pide al maestro crear un eslavo en un nodo distribuido
crea_eslavo(Nodo) ->
   {maestro, nodo(maestro)} ! {crea_eslavo, Nodo},
   ok.
   
% envia mensaje a eslavo a través del maestro
para_eslavo(Mensaje, Neslavo) ->
   {maestro, nodo(maestro)} ! {self(), {mensaje, Mensaje, Neslavo}},
   receive 
      inexistente -> 
	     io:format("El eslavo ~w no existe~n", [Neslavo]);
	  enviado ->
	     {Mensaje, Neslavo}
   end.
		
% termina el proceso maestro
termina() ->
   {maestro, nodo(maestro)} ! termina,
   'El maestro termino'.
   
% nombre corto del servidor (nombre@máquina)
nodo(Nombre) -> list_to_atom(atom_to_list(Nombre)++"@LAPTOP-5").

% CÓDIGO PARA EslaVOS

eslavo(N) ->
   receive
      {mensaje, morir} ->
	     io:format("El eslavo ~w ha muerto~n", [N]);
      {mensaje, M} ->
	     io:format("El eslavo ~w recibió el mensaje ~w~n",
		           [N, M]),
	     eslavo(N)
   end.
   
					      
					
    
