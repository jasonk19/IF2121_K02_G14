move :- create_map.

w :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y - 1, (Y1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

w :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y - 1,
  retract(map_object(X,Y,P)),
  assertz(map_object(X,Y1,P)), !,
  move.

s :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y + 1, (Y1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

s :-
  map_player(P), map_object(X,Y,P),
  Y1 is Y + 1,
  retract(map_object(X,Y,P)),
  assertz(map_object(X,Y1,P)), !,
  move.

a :-
  map_player(P), map_object(X,Y,P),
  X1 is X - 1, (X1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

a :-
  map_player(P), map_object(X,Y,P),
  X1 is X - 1,
  retract(map_object(X,Y,P)),
  assertz(map_object(X1,Y,P)), !,
  move.

d :-
  map_player(P), map_object(X,Y,P),
  X1 is X + 1, (X1 =:= 0 -> (move, nl, write('You hit a fence!'), !)).

d :-
  map_player(P), map_object(X,Y,P),
  X1 is X + 1,
  retract(map_object(X,Y,P)),
  assertz(map_object(X1,Y,P)), !,
  move.

