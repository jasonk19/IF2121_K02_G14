:- dynamic(day/1).
/* day(hari) -> setiap move hari nambah 1*/

move :- create_map.

w :- inHouse, !, write('You are at your House, please exit your House to move').
w :- inMarket, !, write('You are at the Market, please exit the Market to move').
w :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

w :-
  planted(_,_,_,Time),
  (Time =:= 0 -> (!) ; NTime is Time - 1, retract(planted(_,_,_,Time)), assertz(planted(_,_,_,NTime)), !).

w :-
  map_player(P), map_object(X,Y,P,_),
  Y1 is Y - 1, (Y1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

w :-
  map_player(P), map_object(X,Y,P,_),
  tile_air(A), map_object(XA,YA,A,_),
  (YA =:= Y - 1 -> (XA =:= X -> (move, nl, write('You can\'t get into water!'), !))).

w :-
  map_player(P), map_object(X,Y,P,_),
  Y1 is Y - 1,
  day(H), NH is H + 1,
  retract(day(H)),
  asserta(day(NH)),
  retract(map_object(X,Y,P,_)),
  asserta(map_object(X,Y1,P,_)), !,
  move, nl, write('You moved north.').

s :- inHouse, !, write('You are at your House, please exit your House to move').
s :- inMarket, !, write('You are at the Market, please exit the Market to move').
s :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

s :-
  planted(_,_,_,Time),
  (Time =:= 0 -> (!) ; NTime is Time - 1, retract(planted(_,_,_,Time)), assertz(planted(_,_,_,NTime)), !).

s :-
  map_player(P), map_object(X,Y,P,_), map_size(S),
  Y1 is Y + 1, (Y1 =:= S + 1 -> (move, nl, write('You hit a fence!'), !)).

s :-
  map_player(P), map_object(X,Y,P,_),
  tile_air(A), map_object(XA,YA,A,_),
  (YA =:= Y + 1 -> (XA =:= X -> (move, nl, write('You can\'t get into water!'), !))).

s :-
  map_player(P), map_object(X,Y,P,_),
  Y1 is Y + 1,
  day(H), NH is H + 1,
  retract(day(H)),
  asserta(day(NH)),
  retract(map_object(X,Y,P,_)),
  asserta(map_object(X,Y1,P,_)), !,
  move, nl, write('You moved south.').

a :- inHouse, !, write('You are at your House, please exit your House to move').
a :- inMarket, !, write('You are at the Market, please exit the Market to move').
a :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

a :-
  planted(_,_,_,Time),
  (Time =:= 0 -> (!) ; NTime is Time - 1, retract(planted(_,_,_,Time)), assertz(planted(_,_,_,NTime)), !).

a :-
  map_player(P), map_object(X,Y,P,_),
  X1 is X - 1, (X1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

a :-
  map_player(P), map_object(X,Y,P,_),
  tile_air(A), map_object(XA,YA,A,_),
  (XA =:= X - 1 -> (YA =:= Y -> (move, nl, write('You can\'t get into water!'), !))).

a :-
  map_player(P), map_object(X,Y,P,_),
  X1 is X - 1,
  day(H), NH is H + 1,
  retract(day(H)),
  asserta(day(NH)),
  retract(map_object(X,Y,P,_)),
  asserta(map_object(X1,Y,P,_)), !,
  move, nl, write('You moved west.').

d :- inHouse, !, write('You are at your House, please exit your House to move').
d :- inMarket, !, write('You are at the Market, please exit the Market to move').
d :- inRanch, !, write('You are at your Ranch, please exit your Ranch to move').

d :-
  planted(_,_,_,Time),
  (Time =:= 0 -> (!) ; NTime is Time - 1, retract(planted(_,_,_,Time)), assertz(planted(_,_,_,NTime)), !).

d :-
  map_player(P), map_object(X,Y,P,_), map_size(S),
  X1 is X + 1, (X1 =:= S + 1 -> (move, nl, write('You hit a fence!'), !)).

d :-
  map_player(P), map_object(X,Y,P,_),
  tile_air(A), map_object(XA,YA,A,_),
  (XA =:= X + 1 -> (YA =:= Y -> (move, nl, write('You can\'t get into water!'), !))).

d :-
  map_player(P), map_object(X,Y,P,_),
  X1 is X + 1,
  day(H), NH is H + 1,
  retract(day(H)),
  asserta(day(NH)),
  retract(map_object(X,Y,P,_)),
  asserta(map_object(X1,Y,P,_)), !,
  move, nl, write('You moved east.').

