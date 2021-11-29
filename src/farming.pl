:- dynamic(planted/4).
/* planted(X,Y,id,time) */

dig :-
  map_player(P), map_object(X,Y,P,_),
  inventory(ID,_,_,_,_,_,_,_),
  digged_tile(D), 
  Y1 is Y - 1,
  Y2 is Y + 1,
  (ID =:= 103 -> (
    retract(map_object(X,Y,P,_)),
    assertz(map_object(X,Y,D,_)),
    assertz(map_object(X,Y2,D,_)),
    asserta(map_object(X,Y1,P,_)), !
  ) ; 
    retract(map_object(X,Y,P,_)),
    assertz(map_object(X,Y,D,_)),
    asserta(map_object(X,Y1,P,_)), !
  ),
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
    (write('1. '), write(Carrotq), write(' '), write('Carrot Seed')), nl,
    (write('2. '), write(Cornq), write(' '), write('Corn Seed')), nl,
    (write('3. '), write(Potatoq), write(' '), write('Potato Seed')), nl,
    (write('4. '), write(Tomatoq), write(' '), write('Tomato Seed')), nl,
    nl,
    write('What do you want to plant?'), nl,
    read(Inp),
    (Inp =:= 1 -> (Carrotq > 0 -> (plantSeed(X,XD,Y,YD,D,C,P,55), delItems(51,1)) ; write('You don\'t have carrot seed')) ; 
    (Inp =:= 2 -> (Cornq > 0 -> (plantSeed(X,XD,Y,YD,D,C,P,56), delItems(52,1)) ; write('You don\'t have corn seed'))) ; 
    (Inp =:= 3 -> (Potatoq > 0 -> (plantSeed(X,XD,Y,YD,D,C,P,57), delItems(53,1)) ; write('You don\'t have potato seed'))) ; 
    (Inp =:= 4 -> (Tomatoq > 0 -> (plantSeed(X,XD,Y,YD,D,C,P,58), delItems(54,1)) ; write('You don\'t have tomato seed'))))) ;  
    write('You are not at digged tile!'), !) ; write('You are not at digged tile!'), !).

plantSeed(X,XD,Y,YD,D,C,P,ID) :-
  Y1 is Y - 1, retract(map_object(X,Y,P)), retract(map_object(XD,YD,D)), asserta(map_object(XD,YD,C,ID)), asserta(planted(XD,YD,ID,8)), asserta(map_object(X,Y1,P)), !.

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