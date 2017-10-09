%%%-------------------------------------------------------------------
%% @doc DockerTest public API
%% @end
%%%-------------------------------------------------------------------

-module(dockertest_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    dockertest_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================