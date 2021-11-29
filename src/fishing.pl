


fish :- 
	isNearObject('o'), inventory(_,wooden_fishing_rod,_,_,_,_,_,_),
	player(_, _, _, _, FishLevel, _, _, _, _, _),
	( FishLevel < 5
	-> random(1, 4, FishID), random(0,6,Qty)
	
	; 	( FishLevel < 10 
		-> random(1, 7, FishID), random(0,6,Qty)
	
		; 	( FishLevel < 15
			-> random(1, 10, FishID), random(0,6,Qty)
		
			;	random(1, 11, FishID), random(0,6,Qty)
			
			)
		)
	),

	( Qty =:= 0
	-> write('You didnt get anything!'), nl,
	addFishExp(5),!
	
	; addItems(FishID,Qty),nl,
	TotalXP is Qty * 5,
	addFishExp(5 + TotalXP),!
	
	).

fish :- 
	isNearObject('o'), inventory(_,stone_fishing_rod,_,_,_,_,_,_),
	player(_, _, _, _, FishLevel, _, _, _, _, _),
	( FishLevel < 5
	-> random(1, 4, FishID), random(0,11,Qty)
	
	; 	( FishLevel < 10 
		-> random(1, 7, FishID), random(0,11,Qty)
	
		; 	( FishLevel < 15
			-> random(1, 10, FishID), random(0,11,Qty)
		
			;	random(1, 11, FishID), random(0,11,Qty)
			
			)
		)
	),

	( Qty =:= 0
	-> write('You didnt get anything!'), nl,
	addFishExp(5),!
	
	; addItems(FishID,Qty),nl,
	TotalXP is Qty * 5,
	addFishExp(5 + TotalXP),!
	
	).
