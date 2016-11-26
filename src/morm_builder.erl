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

-module(morm_builder).
-compile(export_all).

filename(Collection) when is_atom(Collection) ->
	filename(atom_to_list(Collection))
;
filename(Collection) ->
	Prefix = get_prefix(),
    Prefix ++ Collection
.

get_prefix() ->
	case application:get_env(morm, prefix) of
		{ok, P} -> P;
		_ -> ""
	end
.

get_adapter() ->
	case application:get_env(morm, db_adapter) of
		{ok, P} -> P;
		_ -> db_dummy
	end
.

make_header(Collection) when is_atom(Collection) ->
	make_header(atom_to_list(Collection))
;
make_header(Collection) ->
	Prefix = get_prefix(),
	Text=io_lib:format("-module(~s~s).
-compile(export_all).
", [Prefix, Collection])
.

make_insert(Collection, Fields) when is_atom(Collection) ->
	make_insert(atom_to_list(Collection), Fields)
;

make_insert(Collection, Fields) ->
	Adapter=get_adapter(),
	ok
.
