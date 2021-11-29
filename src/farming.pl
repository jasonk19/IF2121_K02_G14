:- dynamic(planted/4).
/* planted(X,Y,id,time) */

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
    itemAmount(51,Carrotq),
    itemAmount(52,Cornq),
    itemAmount(53,Potatoq),
    itemAmount(54,Tomatoq),
    (Carrotq > 0 -> (Cornq > 0 -> (Potatoq > 0 -> (Tomatoq > 0 -> (
      (Carrotq > 0 -> (write('- '), write(Carrotq), write(' '), write(Ca))),
      (Cornq > 0 -> (write('- '), write(Cornq), write(' '), write(Co))),
      (Potatoq > 0 -> (write('- '), write(Potatoq), write(' '), write(Po))),
      (Tomatoq > 0 -> (write('- '), write(Tomatoq), write(' '), write(To))),
      nl,
      write('What do you want to plant?'), nl,
      read(Inp),
      (Inp = 'carrot' -> (delItems(51,1), plantSeed(X,XD,Y,YD,D,C,P,55))) ;
      (Inp = 'corn' -> (delItems(52,1), plantSeed(X,XD,Y,YD,D,C,P,56))) ;
      (Inp = 'potato' -> (delItems(53,1), plantSeed(X,XD,Y,YD,D,C,P,57))) ;
      (Inp = 'tomato' -> (delItems(54,1), plantSeed(X,XD,Y,YD,D,C,P,58)))
    ))))) ; write('You have no seed in your inventory.'), !)) ; write('You are not at digged tile.'), !) ; write('You are not at digged tile.'), !.

plantSeed(X,XD,Y,YD,D,C,P,ID) :-
  Y1 is Y - 1, retract(map_object(X,Y,P)), retract(map_object(XD,YD,D)), assertz(map_object(XD,YD,C,ID)), asserta(planted(XD,YD,ID,8)), asserta(map_object(X,Y1,P)), !.

harvest :-
  items(55,Ca,A,_,_,_,_,_),
  items(56,Co,B,_,_,_,_,_),
  items(57,Po,C,_,_,_,_,_),
  items(58,To,D,_,_,_,_,_),
  player(Job,_,_,_,_,_,_,_,_,_),
  map_player(P), map_object(X,Y,P,_),
  map_planted(C), map_object(XP,YP,C,ID),
  digged_tile(D),
  planted(XP,YP,ID,Time),
  Y1 is Y - 1,
  (X =:= XP -> (Y =:= YP -> (
    (ID =:= 55 -> (Time =:= 0 -> (
      retract(planted(XP,YP,ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested carrot.'), (Job == farmer -> (addFarmExp(10), addExp(10), !) ; (addFarmExp(5), addExp(5), !)), !
    ) ; write('Harvest not ready!'), !)),
    (ID =:= 56 -> (Time =:= 0 -> (
      retract(planted(XP,YP,ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested corn.'), (Job == farmer -> (addFarmExp(10), addExp(10), !) ; (addFarmExp(5), addExp(5), !)), !
    ) ; write('Harvest not ready!'), !)),
    (ID =:= 57 -> (Time =:= 0 -> (
      retract(planted(XP,YP,ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested potato.'), (Job == farmer -> (addFarmExp(10), addExp(10), !) ; (addFarmExp(5), addExp(5), !)), !
    ) ; write('Harvest not ready!'), !)),
    (ID =:= 58 -> (Time =:= 0 -> (
      retract(planted(XP,YP,ID,Time)), retract(map_object(XP,YP,C,ID)), assertz(map_object(XP,YP,D,_)), asserta(map_object(X,Y1,P,_)), addItems(ID,1), write('You harvested tomato.'), (Job == farmer -> (addFarmExp(10), addExp(10), !) ; (addFarmExp(5), addExp(5), !)), !
    ) ; write('Harvest not ready!'), !))) ; write('You are not at planted tile!'), !
  ) ; write('You are not at planted tile!'), !).