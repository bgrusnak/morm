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

-module(morm_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    morm_sup:start_link(),
    case application:get_env(morm, schema) of
		{ok, Schema} -> 
			morm:load(Schema),
			ok;
		_ -> ok
    end,
    ok
    .

stop(_State) ->
    ok.
