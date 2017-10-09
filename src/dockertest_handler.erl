-module(dockertest_handler).

-export([
  init/3,
  allowed_methods/2,
  content_types_accepted/2,
  from_json/2
]).

%%====================================================================
%% internal callbacks
%%====================================================================

init(_Transport, _Req, _Opts) ->
  {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
  {[<<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
  {[
    {<<"application/json">>, from_json}
  ], Req, State}.

from_json(Req, State) ->
  Body = jsx:encode(#{
    ok        => <<"true">>
  }),
  {ok, CReply} = cowboy_req:reply(200, [], Body, Req),
  {halt, CReply, State}.
