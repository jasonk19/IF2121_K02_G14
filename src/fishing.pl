:- include('player.pl').
:- include('inventory.pl').

/* Level Fishing */
player(_, _, _, _, 10, _, _, _, _, _).

fish :- 
	player(_, _, _, _, FishLevel, _, _, _, _, _),
	( FishLevel < 10 
	-> random(1, 4, FishID), random(0,6,Qty)
	; random(1, 7, FishID), random(0,6,Qty)),
	( Qty =:= 0
	-> write('You didnt get anything!'), nl, 
	; addItems(FishID,Qty)).
	