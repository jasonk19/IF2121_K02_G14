:- include('player.pl').
:- include('inventory.pl').
:- include('map.pl').

/* Buat testing */
map_object(2,11,'P',_).
map_object(3,11,'o',_).
map_object(4,11,'o',_).
map_object(5,11,'o',_).
map_object(2,12,'o',_).
map_object(3,12,'o',_).
map_object(4,12,'o',_).
map_object(5,12,'o',_).

/* Level Fishing Sementara */


/*  rod blm */

fish :- 
	isNearObject('o'),!,
	player(_, _, _, _, FishLevel, _, _, _, _, _),
	( FishLevel < 5
	-> random(1, 4, FishID), random(0,6,Qty)
	
	; ( FishLevel < 10 
	  -> random(1, 7, FishID), random(0,6,Qty)
	  
	  ; ( FishLevel < 15
	    -> random(1, 10, FishID), random(0,6,Qty)
		
		; random(1, 11, FishID), random(0,6,Qty)
			
		)
	  )
	),
	
	( Qty =:= 0
	-> write('You didnt get anything!'), nl,
	addFishExp(5),!
	
	; addItems(FishID,Qty),nl,
	addFishExp(10),!
	
	).
