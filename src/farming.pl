:- dynamic(planted/2).
/* planted(id, time) */

dig :-
  map_player(P), map_object(X,Y,P,_),
  digged_tile(D), 
  Y1 is Y - 1,
  retract(map_object(X,Y,P,_)),
  assertz(map_object(X,Y,D,_)),
  asserta(map_object(X,Y1,P,_)), !,
  map.

plant :-
  map_player(P), map_object(X,Y,P,_),
  digged_tile(D), map_object(XD,YD,D,_),
  map_planted(C),
  (X =:= XD -> (Y =:= YD -> (
    write('You have:'), nl,
    inventory(51,Ca,Carrotq,_,_,_,_,_),
    inventory(52,Co,Cornq,_,_,_,_,_),
    inventory(53,Po,Potatoq,_,_,_,_,_),
    inventory(54,To,Tomatoq,_,_,_,_,_),
    (Carrotq > 0 -> (write('- '), write(Carrotq), write(' '), write(Ca))),
    (Cornq > 0 -> (write('- '), write(Cornq), write(' '), write(Co))),
    (Potatoq > 0 -> (write('- '), write(Potatoq), write(' '), write(Po))),
    (Tomatoq > 0 -> (write('- '), write(Tomatoq), write(' '), write(To))),
    nl,
    write('What do you want to plant?'), nl,
    read(Inp),
    (Inp = 'carrot' -> (NCarrotq is Carrotq - 1, retract(inventory(51,Ca,Carrotq,_,_,_,_,_)), assertz(inventory(51,Ca,NCarrotq,_,_,_,_,_)), plantSeed(X,XD,Y,YD,D,C,P,55))),
    (Inp = 'corn' -> (NCornq is Cornq - 1, retract(inventory(52,Co,Cornq,_,_,_,_,_)), assertz(inventory(52,Co,NCornq,_,_,_,_,_)), plantSeed(X,XD,Y,YD,D,C,P,56))),
    (Inp = 'potato' -> (NPotatoq is Potatoq - 1, retract(inventory(53,Po,Potatoq,_,_,_,_,_)), assertz(inventory(53,Po,NPotatoq,_,_,_,_,_)), plantSeed(X,XD,Y,YD,D,C,P,57))),
    (Inp = 'tomato' -> (NTomatoq is Tomatoq - 1, retract(inventory(54,To,Tomatoq,_,_,_,_,_)), assertz(inventory(54,To,NTomatoq,_,_,_,_,_)), plantSeed(X,XD,Y,YD,D,C,P,58)))
  ) ; write('You are not at digged tile!'), !) ; write('You are not at digged tile!'), !).

plantSeed(X,XD,Y,YD,D,C,P,ID) :-
  Y1 is Y - 1, retract(map_object(X,Y,P)), retract(map_object(XD,YD,D)), assertz(map_object(XD,YD,C,ID)), assertz(planted(ID,5)), asserta(map_object(X,Y1,P)), !.

harvest :-
  items(55,Ca,A,_,_,_,_,_),
  items(56,Co,B,_,_,_,_,_),
  items(57,Po,C,_,_,_,_,_),
  items(58,To,D,_,_,_,_,_),
  map_player(P), map_object(X,Y,P,_),
  map_planted(C), map_object(XP,YP,C,ID),
  digged_tile(D),
  planted(ID,Time),
  Y1 is Y - 1,
  (X =:= XP -> (Y =:= YP -> (
    (ID =:= 55 -> (Time =:= 0 -> (
      retract(planted(ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested carrot.'), !
    ))),
    (ID =:= 56 -> (Time =:= 0 -> (
      retract(planted(ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested corn.'), !
    ))),
    (ID =:= 57 -> (Time =:= 0 -> (
      retract(planted(ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested potato.'), !
    ))),
    (ID =:= 58 -> (Time =:= 0 -> (
      retract(planted(ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested tomato.'), !
    )))) ; write('You are not at planted tile!'), !
  ) ; write('You are not at planted tile!'), !).