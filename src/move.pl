move :- create_map.

w :- inHouse, !, write('You are at your House, please exit your House to move').
w :- inMarket, !, write('You are at the Market, please exit the Market to move').
w :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

w :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y - 1, (Y1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

w :-
  map_player(P), map_object(X,Y,P),
  tile_air(A), map_object(XA,YA,A),
  (YA =:= Y - 1 -> (move, nl, write('You cannot cross a lake!'), !)).

w :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y - 1,
  retract(map_object(X,Y,P)),
  asserta(map_object(X,Y1,P)), !,
  move.

s :- inHouse, !, write('You are at your House, please exit your House to move').
s :- inMarket, !, write('You are at the Market, please exit the Market to move').
s :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

s :-
  map_player(P), map_object(X,Y,P), map_size(S),
  Y1 is Y + 1, (Y1 =:= S + 1 -> (move, nl, write('You hit a fence!'), !)).

s :-
  map_player(P), map_object(X,Y,P),
  tile_air(A), map_object(XA,YA,A),
  (YA =:= Y + 1 -> (move, nl, write('You cannot cross a lake!'), !)).

s :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y + 1,
  retract(map_object(X,Y,P)),
  asserta(map_object(X,Y1,P)), !,
  move.

a :- inHouse, !, write('You are at your House, please exit your House to move').
a :- inMarket, !, write('You are at the Market, please exit the Market to move').
a :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

a :-
  map_player(P), map_object(X,Y,P),
  X1 is X - 1, (X1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

a :-
  map_player(P), map_object(X,Y,P),
  tile_air(A), map_object(XA,YA,A),
  (XA =:= X - 1 -> (move, nl, write('You cannot cross a lake!'), !)).

a :-
  map_player(P), map_object(X,Y,P),
  X1 is X - 1,
  retract(map_object(X,Y,P)),
  asserta(map_object(X1,Y,P)), !,
  move.

d :- inHouse, !, write('You are at your House, please exit your House to move').
d :- inMarket, !, write('You are at the Market, please exit the Market to move').
d :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

d :-
  map_player(P), map_object(X,Y,P), map_size(S),
  X1 is X + 1, (X1 =:= S + 1 -> (move, nl, write('You hit a fence!'), !)).

d :-
  map_player(P), map_object(X,Y,P),
  tile_air(A), map_object(XA,YA,A),
  (XA =:= X + 1 -> (move, nl, write('You cannot cross a lake!'), !)).

d :-
  map_player(P), map_object(X,Y,P),
  X1 is X + 1,
  retract(map_object(X,Y,P)),
  asserta(map_object(X1,Y,P)), !,
  move.

