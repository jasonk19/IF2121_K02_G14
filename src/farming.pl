dig :-
  map_player(P), map_object(X,Y,P),
  digged_tile(D), 
  Y1 is Y - 1,
  retract(map_object(X,Y,P)),
  assertz(map_object(X,Y,D)),
  assertz(map_object(X,Y1,P)), !,
  map.

plant :-
  map_player(P), map_object(X,Y,P),
  digged_tile(D), map_object(XD,YD,D),
  map_planted(C),
  (YD =:= Y + 1 -> retract(map_object(XD,YD,D)), assertz(map_object(XD,YD,C)), !, map).