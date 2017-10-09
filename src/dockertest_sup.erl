%%%-------------------------------------------------------------------
%% @doc DockerTest top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(dockertest_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, { {one_for_all, 0, 1}, [
    {
      dockertest_rest_worker,
      { dockertest_rest_worker, start_link, [] },
      permanent,
      brutal_kill, 
      worker,
      [dockertest_rest_worker]
    }
    ]} }.

%%====================================================================
%% Internal functions
%%====================================================================
