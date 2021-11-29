

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
    player(_, _, _, _, _, _, _, _, _, Gold),
    format('Current Gold: ~w ~n',[Gold]),
    write('What do you want to buy?'), nl,
	write('1. Carrot seed (30 golds)'), nl,
	write('2. Corn seed (50 golds)'), nl,
	write('3. Tomato seed (100 golds)'), nl,
	write('4. Potato seed (60 golds)'), nl,
	write('5. Chicken (500 golds)'), nl,
	write('6. Sheep (700 golds)'), nl,
	write('7. Cow (1000 golds)'), nl,
	write('8. Shovel (200 golds)'), nl,
    write('9. Upgrade Rod to Stone fishing rod (300 golds)'), nl.

buy :-
    (inMarket 
        -> displayMarket, write('> '), read(Num), nl,

        ( Num =:= 1
            -> write('How many do you want to buy?'),nl,
            write('> '), read(BuyQty), nl,
            items(_,carrot_seed,_,_,Price,_,_,_),
            player(_, _, _, _, _, _, _, _, _, Gold),
            Total is BuyQty * Price,
            ( Total =< Gold
                -> addItems(carrot_seed,BuyQty),nl,
                format('You have bought ~w Carrot seed.', [BuyQty]),nl,
                reduceGold(Total),nl
                ; write('Not enough golds'),nl)
        
            ; Num =:= 2
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,corn_seed,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(corn_seed,BuyQty),nl,
                    format('You have bought ~w Corn seed.', [BuyQty]),nl,
                    reduceGold(Total),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 3
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,tomato_seed,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(tomato_seed,BuyQty),nl, 
                    format('You have bought ~w Tomato seed.', [BuyQty]),nl,
                    reduceGold(Total),nl
                    ; write('Not enough golds'),nl)
        
            ; Num =:= 4
                -> write('How many do you want to buy?'),nl,
                write('> '), read(BuyQty), nl,
                items(_,potato_seed,_,_,Price,_,_,_),
                player(_, _, _, _, _, _, _, _, _, Gold),
                Total is BuyQty * Price,
                ( Total =< Gold
                    -> addItems(potato_seed,BuyQty),nl,
                    format('You have bought ~w Potato seed.', [BuyQty]),nl,
                    reduceGold(Total),nl
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
                    reduceGold(Total),nl
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
                    reduceGold(Total),nl
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
                    reduceGold(Total),nl
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
                    reduceGold(Total),nl
                    ; write('Not enough golds'),nl)

            ; Num =:= 9
            -> write('How many do you want to buy?'),nl,
            write('> '), read(BuyQty), nl,
            items(_,stone_fishing_rod,_,_,Price,_,_,_),
            player(_, _, _, _, _, _, _, _, _, Gold),
            Total is BuyQty * Price,
            ( Total =< Gold
                -> addItems(stone_fishing_rod,BuyQty),nl,
                delItems(wooden_fishing_rod,1),nl,
                format('You have bought ~w Stone Fishing Rod.', [BuyQty]),nl,
                reduceGold(Total),nl
                ; write('Not enough golds'),nl))

        ; write('You are not at the Market!')).

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
            format('You sold ~w ~w. ~n', [SellQty, ItemName]),
            addGold(Total),goalCheck)

        ; write('You are not at the Market!')).

exitMarket :-
    (inMarket -> retract(inMarket), write('You have left the Market') ; write('You are not at the Market!')).
