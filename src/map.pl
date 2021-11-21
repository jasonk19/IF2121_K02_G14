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

map_size(17).

map_structure :- tile_structure, loc_structure.

/* Location's Structure */
loc_structure :- 
  map_size(S), map_marketplace(M), map_ranch(R), map_house(H), map_quest(Q),
  XM is div(S, 3), YM is div(S, 3),
  MarketX is XM + 10, MarketY is YM + 4,
  random(3, MarketX, X), random(1,MarketY,Y), asserta(map_object(X,Y,M)),
  RanchX is MarketX + XM,
  random(MarketX, RanchX, X2), random(1, MarketY, Y2), asserta(map_object(X2,Y2,R)),
  HouseY is MarketY + YM,
  random(1, MarketX, X3), random(MarketY, HouseY, Y3), asserta(map_object(X3,Y3,H)),
  QuestX is MarketX + XM, QuestY is MarketY + YM,
  random(MarketX, QuestX, X4), random(MarketY, QuestY, Y4), asserta(map_object(X4,Y4,Q)).


/* Tile Locations */
tile_structure :- 
  generate_tile_air, generate_digged_tile,
  (digged_tile_chance -> (tile_air_chance -> true ; true) ; (tile_air_chance -> true ; true)).

tile_air_chance :- random(0, 40, TA), (TA >= 15), generate_tile_air.
digged_tile_chance :- random(0,40,DT), (DT >= 15), generate_digged_tile.

generate_tile_air :- 
  map_size(S), TileMin is div(S,5), TileMax is div(S,2),
  random(TileMin, TileMax, Tiles),
  random(Tiles,S,StartY), random(13, S, StartX),
  create_tile_air(StartX, StartY, Tiles), !.

create_tile_air(X,Y,1) :- tile_air(Air), assertz(map_object(X,Y,Air)).

create_tile_air(X,Y,N) :- 
  tile_air(Air), assertz(map_object(X,Y,Air)),
  N2 is N - 1, NY is Y - 1, create_tile_air(X, NY, N2).

generate_digged_tile :- 
  map_size(S), TileMin is div(S,6), TileMax is div(S,3),
  random(TileMin, TileMax, Tiles),
  random(1,S,StartX), random(1, 10, StartY),
  create_digged_tile(StartX, StartY, Tiles), !.

create_digged_tile(X,Y,1) :- digged_tile(Digged), assertz(map_object(X,Y,Digged)).

create_digged_tile(X,Y,N) :- 
  digged_tile(Digged), assertz(map_object(X,Y,Digged)),
  N2 is N - 1, NX is X - 1, create_digged_tile(NX, Y, N2).

/* Fence Structure */

/* TOP */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X < S + 1, X > 0, Y =:= 0,
  write(F),
  DX is X + 1, create_point(DX, Y), !.

/* RIGHT */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X =:= S + 1, Y =< S + 1,
  write(F), nl,
  DY is Y + 1, create_point(0, DY), !.

/* BOTTOM */
create_point(X,Y) :-
  map_size(S), map_fence(F),
  X < Y + 1, X > 0, Y =:= S + 1,
  write(F),
  DX is X + 1, create_point(DX, Y), !.

/* LEFT */
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
map :- map_structure, create_map.