:- include('map.pl').
:- include('inventory.pl').


/* Buat testing */
map_object(2,3,'P',_).
map_object(2,3,'R',_).
player('rancher', _, 3, 20,_,_,_,_,25,_).


ranch :-
  map_player(P), map_object(X,Y,P,_),
  map_ranch(R), map_object(XR,YR,R,_),
  (X =:= XR -> (Y =:= YR -> assertz(inRanch), write('You have entered the Ranch, input "exitRanch" to exit the Ranch'), nl, welcomeMsg, ! ; write('You are not at the Ranch!'), !) ; write('You are not at the Ranch!'), !).



exitRanch :-
  (inRanch -> retract(inRanch), write('You have left the Ranch') ; write('You are not at the Ranch!')).

/* Awal-awal sudah punya chicken, sheep, sama cow yang jumlahnya tidak nol */
welcomeMsg :-
    write('Welcome to the ranch! You have: ' ), nl,
    inventory(21, X, Cowq, _,_,_,_,_),
    inventory(22, Y, Sheepq, _,_,_,_,_),
    inventory(23, Z, Chickenq, _,_,_,_,_),
    write(Chickenq), write(' '), write(Z), nl,
    write(Sheepq), write(' '), write(Y), nl,
    write(Cowq), write(' '), write(X), nl,
    write('What do you want to do?').

/* Belum Implementasi dengan waktu dan ranching level */

randomMilkbyLevel(FarmLevel, MilkID, MilkExp) :-
  FarmLevel == 1 -> MilkID is 24, MilkExp is 1;
  FarmLevel == 2 -> random(24, 26, M), MilkID is M, (MilkID == 24 -> MilkExp is 1; MilkExp is 2);
  FarmLevel == 3 -> random(24, 27, M), MilkID is M, (MilkID == 24 -> MilkExp is 1; MilkID == 25 -> MilkExp is 2; MilkExp is 3).


randomWoolbyLevel(FarmLevel, WoolID, WoolExp) :-
  FarmLevel == 1 -> WoolID is 27, WoolExp is 1;
  FarmLevel == 2 -> random(27, 29, W), WoolID is W, (WoolID == 27 -> WoolExp is 1; WoolExp is 2);
  FarmLevel == 3 -> random(27, 30, W), WoolID is W, (WoolID == 27 -> WoolExp is 1; WoolID == 28 -> WoolExp is 2; WoolExp is 3).

randomEggbyLevel(FarmLevel, EggID, EggExp) :-
  FarmLevel == 1 -> EggID is 30, EggExp is 1;
  FarmLevel == 2 -> random(30, 32, E), EggID is E, (EggID == 30 -> EggExp is 1; EggExp is 2);
  FarmLevel == 3 -> random(30, 33, E), EggID is E, (EggID == 30 -> EggExp is 1; EggID == 31 -> EggExp is 2; EggExp is 3).



cow :-
    player(Job, _, FarmLevel, FarmExp,_,_,_,_,Exp,_),
    (inRanch ->
    (Job == rancher ->
    inventory(21, X, Q,_,_,_,_,_),
    write('You milked your cow!'), nl,
    write('You got '), randomMilkbyLevel(FarmLevel, MilkID, MilkExp), addItems(MilkID, Q), nl,
    Xpgained is Q*MilkExp*2,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!')), !;
    write('Either you are not a Rancher or you are not in ranch!'), nl, !).

sheep :-
    player(Job, _, FarmLevel, FarmExp,_,_,_,_,Exp,_),
    (inRanch ->
    (Job == rancher ->
    inventory(22, X, Q,_,_,_,_,_),
    write('You sheared your sheep!'), nl,
    write('You got '), randomWoolbyLevel(FarmLevel, WoolID, WoolExp), addItems(WoolID, Q), nl, 
    Xpgained is Q*WoolExp*3,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!')), !;
    write('Either you are not a Rancher or you are not in ranch!'), nl, !).

chicken :-
    player(Job, _, FarmLevel, FarmExp,_,_,_,_,Exp,_),
    (inRanch ->
    (Job == rancher ->
    inventory(23, X, Q,_,_,_,_,_),
    write('Your chicken lays '), write(Q), write(' eggs.'), nl,
    write('You got '), randomEggbyLevel(FarmLevel, EggID, EggExp), addItems(EggID, Q), nl,
    Xpgained is Q*EggExp*3,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!')), !;
    write('Either you are not a Rancher or you are not in ranch!'), nl, !).
