-module(dockertest_rest_worker).

-export([ start_link/0 ]).

-include("dockertest_routes.hrl").

start_link() ->
  Port = 8081,
  Dispatch = cowboy_router:compile(?ROUTES),
  cowboy:start_http(http, 100, [{port, Port}], [
    {env, [{dispatch, Dispatch}]},
    {middlewares, [cowboy_router, cowboy_handler]}
  ]).
