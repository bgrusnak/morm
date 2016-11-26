%%% @author Ilya A.Shlyakhovoy <ilya_cat@mail.ru>
%%% @copyright (C) 2016 Ilya A.Shlyakhovoy
%%%
%%% This software is free software; you can redistribute it and/or
%%% modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version 2 of the
%%% License, or (at your option) any later version.
%%%
%%% This software is distributed in the hope that it will be useful, but
%%% WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%% General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License
%%% along with this software; if not, write to the Free Software Foundation,
%%% Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
%%%
%%% @end

-module(morm).

%% API.
-export([start/0, load/1]).

%% API.

start() ->
	ok = application:start(compiler),
	ok = application:start(syntax_tools),
	ok = application:start(sync),
	ok = application:start(fast_yaml),
	application:start(morm)
,io:format("start~n",[])
.

load(Schema) ->
	Collections=parse(Schema),
	build(Collections)
.

parse(Schema) ->
	case fast_yaml:decode_from_file(Schema, [plain_as_atom]) of
		{ok, [Decoded]} -> Decoded;
		_ -> error
	end
.

build(error) -> error;
build([]) -> [];
build([Collection|Tail]) ->
	build_table(Collection),
	build(Tail)
.
build_table({Name, [{<<"columns">>, Columns}, {<<"relations">>, Relations }]}) ->
%	io:format("~p~n~p~n~p~n", [Name, Columns, Relations]),
	
	Header=lists:flatten(morm_builder:header(Name)),
	io:format("~p~n", [Header])
.

insert(Collection, RecordMap) ->
	Cl=list_to_atom(morm_builder:filename(Collection)),
	Cl:insert(RecordMap)
.
