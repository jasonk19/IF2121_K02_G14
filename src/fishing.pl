:- include('player.pl').
:- include('inventory.pl').

/* Level Fishing Sementara */
player(_, _, _, _, 10, _, _, _, _, _).

/*  Validasi map & dpt exp blm */

fish :- 
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
	-> write('You didnt get anything!'), nl
	
	; addItems(FishID,Qty)
	
	).
