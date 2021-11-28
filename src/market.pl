:- include('inventory.pl').
:- include('map.pl').

/* Buat testing */
map_object(2,3,'P',_).
map_object(2,3,'M',_).

/* Gold player */
player(_, _, _, _, _, _, _, _, _, 149).

market :-
    map_player(P), map_object(X,Y,P,_),
    map_marketplace(M), map_object(XM,YM,M,_),
    (X =:= XM -> (Y =:= YM -> assertz(inMarket),
    write('You have entered the Market. What do you want to do?'), nl,
    write('buy?'),nl,
    write('sell?'),nl,
    write('exitMarket?'),nl,!
    ; write('You are not at the Market!'), !) 
    ; write('You are not at the Market!'), !).

displayMarket :- 
    write('What do you want to buy?'), nl,
	write('1. Carrot seed (50 golds)'), nl,
	write('2. Corn seed (50 golds)'), nl,
	write('3. Tomato seed (50 golds)'), nl,
	write('4. Potato seed (50 golds)'), nl,
	write('5. Chicken (500 golds)'), nl,
	write('6. Sheep (1000 golds)'), nl,
	write('7. Cow (1500 golds)'), nl,
	write('8. Level 2 shovel (300 golds)'), nl,
	write('9. Level 2 fishing rod (500 golds)'), nl.

/* blom ngurangin duit */

buy :-
    (inMarket 
        -> displayMarket, write('> '), read(Num), nl,

        ( Num =:= 1
            -> write('How many do you want to buy?'),nl,
            write('> '), read(BuyQty), nl,
            items(_,carrot,_,_,Price,_,_,_),
            player(_, _, _, _, _, _, _, _, _, Gold),
            Total is BuyQty * Price,
            ( Total =< Gold
                -> addItems(carrot,BuyQty),nl,
                format('You have bought ~w Carrot seed.', [BuyQty]),nl,
                format('You are charged ~w golds.', [Total]),nl
                ; write('Not enough golds'),nl)
        
            ; Num =:= 2
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,corn,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(corn,BuyQty),nl,
                    format('You have bought ~w Corn seed.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 3
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,tomato,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(tomato,BuyQty),nl, 
                    format('You have bought ~w Tomato seed.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 4
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,potato,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(potato,BuyQty),nl,
                    format('You have bought ~w Potato seed.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 5
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,chicken,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(chicken,BuyQty),nl,
                    format('You have bought ~w Chicken.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 6
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,sheep,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(sheep,BuyQty),nl,
                    format('You have bought ~w Sheep.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 7
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,cow,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(cow,BuyQty),nl,
                    format('You have bought ~w Cow.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
                
            ; Num =:= 8
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,shovel,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(shovel,BuyQty),nl,
                    format('You have bought ~w Shovel.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 9
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,wooden_fishing_rod,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(wooden_fishing_rod,BuyQty),nl,
                    format('You have bought ~w Fishing Rod.', [BuyQty]),nl,
                    format('You are charged ~w golds.', [Total]),nl
                    ; write('Not enough golds'),nl))

        ; write('You are not at the Market!')).

/* blom nambah duit */

sell :- 
    (inMarket
        -> displayInventory, nl,
        write('What do you want to Sell?'), nl,
	    write('> '), read(ItemName), nl,
        inventory(_,ItemName,Qty,_,_,_,_,_), items(_,ItemName,_,SellPrice,_,_,_,_),
        write('How many do you want to sell?'),nl,
        write('> '), read(SellQty), nl,
        ( SellQty > Qty
            -> format('You dont have enough ~w. Cancelling...', [ItemName])
            ; delItems(ItemName, SellQty), 
            Total is SellPrice * SellQty,
            format('You sold ~w ~w for ~w Golds.', [SellQty, ItemName, Total]))

        ; write('You are not at the Market!')).

exitMarket :-
    (inMarket -> retract(inMarket), write('You have left the Market') ; write('You are not at the Market!')).