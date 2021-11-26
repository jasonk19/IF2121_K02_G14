/* Peta */

/* Generate map_object(X, Y, Loc) -> Loc di posisi (X,Y) */
:- dynamic(map_object/3).

map_fence('#').
map_space('-').
map_marketplace('M').
map_ranch('R').
map_house('H').
map_quest('Q').
tile_air('o').
digged_tile('=').
map_player('P').

map_size(17).

map_structure :- tile_structure, loc_structure.

/* Player Position */
init_player_pos :-
  map_player(P), asserta(map_object(1,1,P)).

/* Location's Structure */
loc_structure :- 
  map_size(S), map_marketplace(M), map_ranch(R), map_house(H), map_quest(Q),
  XM is div(S, 3), YM is div(S, 3),
  MarketX is XM + 10, MarketY is YM + 4,
  random(3, MarketX, X), random(1,MarketY,Y), asserta(map_object(X,Y,M)),
  RanchX is XM + 5,
  random(1, RanchX, X2), random(MarketX, S, Y2), asserta(map_object(X2,Y2,R)),
  HouseY is MarketY + YM,
  random(1, 2, X3), random(MarketY, HouseY, Y3), asserta(map_object(X3,Y3,H)),
  QuestX is MarketX + XM, QuestY is MarketY + YM,
  random(MarketX, QuestX, X4), random(MarketY, QuestY, Y4), asserta(map_object(X4,Y4,Q)).


/* Tile Air Locations */
tile_structure :- 
  generate_tile_air, generate_tile_air,
  (tile_air_chance -> (tile_air_chance -> true ; true)  ;  true).

tile_air_chance :- random(0, 40, TA), (TA >= 30), generate_tile_air.

generate_tile_air :- 
  map_size(S), TileMin is div(S,5), TileMax is div(S,3),
  random(TileMin, TileMax, Tiles),
  random(1,S,StartX), random(10, 15, StartY),
  create_tile_air(StartX, StartY, Tiles), !.

create_tile_air(X,Y,1) :- tile_air(Air), assertz(map_object(X,Y,Air)).

create_tile_air(X,Y,N) :- 
  tile_air(Air), assertz(map_object(X,Y,Air)),
  N2 is N - 1, NX is X - 1, create_tile_air(NX, Y, N2).

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
  map_object(X, Y, Loc), !,
  write(Loc),
  DX is X + 1, create_point(DX, Y), !.

/* EMPTY SPACES */
create_point(X,Y) :-
  map_size(S), map_space(P),
  X < S + 1, X > 0, Y < S + 1, Y > 0,
  (\+ map_object(X,Y,_)),
  write(P),
  DX is X + 1, create_point(DX, Y), !.

create_point(_,_) :- true, !.

/* Main Map */

create_map :- create_point(0,0).
map :- create_map.

