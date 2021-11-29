:- include('map.pl').
:- include('inventory.pl').
:- include('player.pl').
:- dynamic(milktime/1).
:- dynamic(sheartime/1).
:- dynamic(eggtime/1).
/* Buat testing */
map_object(2,3,'P',_).
map_object(2,3,'R',_).
/* milktime(Prev_MilkTime, CurrentTime)*/
milktime(-5).
eggtime(-8).
sheartime(-10).
ranch :-
  map_player(P), map_object(X,Y,P,_),
  map_ranch(R), map_object(XR,YR,R,_),
  (X =:= XR -> (Y =:= YR -> assertz(inRanch), write('You have entered the Ranch, input "exitRanch" to exit the Ranch'), nl, welcomeMsg, ! ; write('You are not at the Ranch!'), !) ; write('You are not at the Ranch!'), !).



exitRanch :-
  (inRanch -> retract(inRanch), write('You have left the Ranch') ; write('You are not at the Ranch!')).

/* Awal-awal sudah punya chicken, sheep, sama cow yang jumlahnya tidak nol */
inventory(21,cow,1,500,1000,1,1,1).
inventory(22,sheep,1,350,700,1,1,1).
inventory(23,chicken,1,250,500,1,1,1).

welcomeMsg :-
    write('Welcome to the ranch! You have: ' ), nl,
    inventory(21, X, Cowq, _,_,_,_,_),
    inventory(22, Y, Sheepq, _,_,_,_,_),
    inventory(23, Z, Chickenq, _,_,_,_,_),
    write(Chickenq), write(' '), write(Z), nl,
    write(Sheepq), write(' '), write(Y), nl,
    write(Cowq), write(' '), write(X), nl,
    write('What do you want to do?').


randomMilkbyLevel(FarmLevel, MilkID, MilkExp) :-
  FarmLevel == 1 -> MilkID is 24, MilkExp is 1;
  FarmLevel == 2 -> random(24, 26, M), MilkID is M, (MilkID == 24 -> MilkExp is 1; MilkExp is 2);
  FarmLevel >= 3 -> random(24, 27, M), MilkID is M, (MilkID == 24 -> MilkExp is 1; MilkID == 25 -> MilkExp is 2; MilkExp is 3).


randomWoolbyLevel(FarmLevel, WoolID, WoolExp) :-
  FarmLevel == 1 -> WoolID is 27, WoolExp is 1;
  FarmLevel == 2 -> random(27, 29, W), WoolID is W, (WoolID == 27 -> WoolExp is 1; WoolExp is 2);
  FarmLevel >= 3 -> random(27, 30, W), WoolID is W, (WoolID == 27 -> WoolExp is 1; WoolID == 28 -> WoolExp is 2; WoolExp is 3).

randomEggbyLevel(FarmLevel, EggID, EggExp) :-
  FarmLevel == 1 -> EggID is 30, EggExp is 1;
  FarmLevel == 2 -> random(30, 32, E), EggID is E, (EggID == 30 -> EggExp is 1; EggExp is 2);
  FarmLevel >= 3 -> random(30, 33, E), EggID is E, (EggID == 30 -> EggExp is 1; EggID == 31 -> EggExp is 2; EggExp is 3).

milkDuration(FarmLevel, X) :-
  FarmLevel == 1 -> X is 5;
  FarmLevel == 2 -> X is 4;
  FarmLevel >= 3 -> X is 3.

shearDuration(FarmLevel, X) :-
  FarmLevel == 1 -> X is 8;
  FarmLevel == 2 -> X is 7;
  FarmLevel >= 3 -> X is 5.

eggDuration(FarmLevel, X) :-
  FarmLevel == 1 -> X is 10;
  FarmLevel == 2 -> X is 9;
  FarmLevel >= 3 -> X is 7.


cow :-
    player(Job, Level, FarmLevel, FarmExp,FishLevel,FishExp,Ranchlevel,RanchExp,Exp,Gold),
    (Job == rancher ->
      (inRanch ->
        (day(X), milktime(Prev), milkDuration(FarmLevel, Y), (X - Prev) >= Y -> 
          inventory(21,_,Q,_,_,_,_,_),
          write('You milked your cow!'), nl,
          write('You got '), randomMilkbyLevel(FarmLevel, MilkID, MilkExp), addItems(MilkID, Q), nl,
          Xpgained is Q*MilkExp*2,
          /* AddExp - Belum diimplementasikan */
          retract(milktime(Prev)), assertz(milktime(X)), nl,
          addRanchExp(Xpgained), addExp(Xpgained), !
        ; 
          write('It is not yet time to milk your cow(s)'), nl,
          write('Please check again later.'), !)
      ;
        write('You are not in ranch'), !)
    ;
      write('You are not a rancher!'), nl, !).

sheep :-
    player(Job, _, FarmLevel, FarmExp,_,_,_,_,Exp,_),
    (Job == rancher ->
      (inRanch ->
        (day(X), sheartime(Prev), shearDuration(FarmLevel, Y), (X - Prev) >= Y ->
            inventory(22, _, Q,_,_,_,_,_),
            write('You sheared your sheep!'), nl,
            write('You got '), randomWoolbyLevel(FarmLevel, WoolID, WoolExp), addItems(WoolID, Q), nl, 
            Xpgained is Q*WoolExp*3,
            /* AddExp - Belum diimplementasikan */
            retract(sheartime(Prev)), assertz(sheartime(X)), nl, 
            addRanchExp(Xpgained), addExp(Xpgained), !
        ; 
          write('It is not yet time to shear your sheep(s)'), nl,
          write('Please check again later.'), !)
        ; 
          write('You are not in ranch'), !)
    ;
      write('You are not a rancher!'), nl, !).

chicken :-
    player(Job, _, FarmLevel, FarmExp,_,_,_,_,Exp,_),
    (Job == rancher ->
        (inRanch ->
          (day(X), eggtime(Prev), eggDuration(FarmLevel, Y), (X - Prev) >= Y ->
            inventory(23, _, Q,_,_,_,_,_),
            write('Your chicken lays '), write(Q), write(' eggs.'), nl,
            write('You got '), randomEggbyLevel(FarmLevel, EggID, EggExp), addItems(EggID, Q), nl,
            Xpgained is Q*EggExp*3,
            /* AddExp - Belum diimplementasikan */
            retract(eggtime(Prev)), assertz(eggtime(X)), nl, 
            addRanchExp(Xpgained), addExp(Xpgained), !
          ; 
            write('Your chicken(s) haven\'t laid any eggs.'), nl,
            write('Please check again later.'), !)
        ;
          write('You are not in ranch'), !)
    ;
      write('You are not a rancher!'), nl, !).
