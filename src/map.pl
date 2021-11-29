/* Peta */

/* Generate map_object(X, Y, Loc, harvestId) -> Loc di posisi (X,Y) */
:- dynamic(map_object/4).

map_fence('#').
map_space('-').
map_marketplace('M').
map_ranch('R').
map_house('H').
map_quest('Q').
tile_air('o').
digged_tile('=').
map_planted('c').
map_player('P').

map_size(17).

map_structure :- loc_structure, tile_air_structure.

/* Player Position */
init_player_pos :-
  map_player(P), asserta(map_object(1,1,P,_)).

/* Location's Structure */

loc_structure :-
  map_size(S), map_marketplace(M), map_ranch(R), map_house(H), map_quest(Q),
  random(5,S,X), random(2,10,Y), asserta(map_object(X,Y,M,_)),
  asserta(map_object(12,10,R,_)),
  asserta(map_object(15,16,H,_)),
  asserta(map_object(10,3,Q,_)).

/* Tile Air */

tile_air_structure :-
  tile_air(A),
  asserta(map_object(3,11,A,_)),
  asserta(map_object(4,11,A,_)),
  asserta(map_object(5,11,A,_)),
  asserta(map_object(2,12,A,_)),
  asserta(map_object(3,12,A,_)),
  asserta(map_object(4,12,A,_)),
  asserta(map_object(5,12,A,_)).

/* Fence Structure */

/* TOP WALL */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X < S + 1, X > 0, Y =:= 0,
  write(F),
  DX is X + 1, create_point(DX, Y), !.

/* RIGHT WALL */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X =:= S + 1, Y =< S + 1,
  write(F), nl,
  DY is Y + 1, create_point(0, DY), !.

/* BOTTOM WALL */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X < Y + 1, X > 0, Y =:= S + 1,
  write(F),
  DX is X + 1, create_point(DX, Y), !.

/* LEFT WALL */
create_point(X,Y) :- 
  map_size(S), map_fence(F),
  X =:= 0, Y =< S + 1,
  write(F),
  DX is X + 1, create_point(DX, Y), !.

/* LOCATIONS */
create_point(X,Y) :-
  map_size(S),
  X < S + 1, X > 0, Y < S + 1, Y > 0,
  map_object(X, Y, Loc,_), !,
  write(Loc),
  DX is X + 1, create_point(DX, Y), !.

/* EMPTY SPACES */
create_point(X,Y) :-
  map_size(S), map_space(P),
  X < S + 1, X > 0, Y < S + 1, Y > 0,
  (\+ map_object(X,Y,_,_)),
  write(P),
  DX is X + 1, create_point(DX, Y), !.

create_point(_,_) :- true, !.

/* Main Map */

create_map :- create_point(0,0).
map :- create_map.

/* CONDITIONS */
:- dynamic(inHouse/0).
:- dynamic(inMarket/0).
:- dynamic(inRanch/0).


/* NEAR OBJECT */

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X-1, map_object(A, Y, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X+1, map_object(A, Y, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is Y-1, map_object(X, A, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is Y+1, map_object(X, A, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X-1, B is Y-1, map_object(A, B, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X-1, B is Y+1, map_object(A, B, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X+1, B is Y-1, map_object(A, B, Obj2, _),
    Obj2 == Obj, !.

isNearObject(Obj) :-
    map_player(P), map_object(X, Y, P, _),
    A is X+1, B is Y+1, map_object(A, B, Obj2, _),
    Obj2 == Obj, !.