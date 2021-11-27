:- include('map.pl').
:- include('inventory.pl').


/* Buat testing */
map_object(2,3,'P').
map_object(2,3,'R').



ranch :-
  map_player(P), map_object(X,Y,P),
  map_ranch(R), map_object(XR,YR,R),
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

cow :-
    inventory(21, X, Q,_,_,_,_,_),
    write('You milked your cow!'), nl,
    write('You got '), addItems(24, Q), nl,
    Xpgained is Q*2,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!').

sheep :-
    inventory(22, X, Q,_,_,_,_,_),
    write('You sheared your sheep!'), nl,
    write('You got '), addItems(27, Q), nl, 
    Xpgained is Q*3,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!').

chicken :-
    inventory(23, X, Q,_,_,_,_,_),
    write('Your chicken lays '), write(Q), write(' eggs.'), nl,
    write('You got '), addItems(30, Q), nl,
    Xpgained is Q*3,
    /* AddExp - Belum diimplementasikan */
    write('You gained '), write(Xpgained), write(' ranching exp!').
