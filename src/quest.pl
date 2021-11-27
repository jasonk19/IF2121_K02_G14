:- include('items.pl').
:- dynamic(quest/6).
:- dynamic(ongoing/0).
/* quest(id_Harvest, qty_Harvest, id_Fish, qty_Fish, id_Ranch, qty_Ranch) */

/* Get quest */
getQuest :-
    write('You need to collect:'),nl,
    random(0,6,Harvest),
    random(0,6,Fish),
    random(0,6,Ranch),

    /* Tentukan Harvest */
    (Harvest > 0 ->
        random(55,59,Harvest_id),
        items(Harvest_id,Harvest_name,_,_,_,_,_,_),
        write('- '),write(Harvest),write(' '),write(Harvest_name),nl
    ;
        !),

    /* Tentukan Fish */
    (Fish > 0 ->
        (random(1,4,Fish_type),
        Fish_type == 1 ->
            random(1,4,Fish_id),
            items(Fish_id,Fish_name,_,_,_,_,_,_),
            write('- '),write(Fish),write(' '),write(Fish_name),nl
        ;Fish_type == 2 ->
            random(4,7,Fish_id),
            items(Fish_id,Fish_name,_,_,_,_,_,_),
            write('- '),write(Fish),write(' '),write(Fish_name),nl
        ;
            random(7,10,Fish_id),
            items(Fish_id,Fish_name,_,_,_,_,_,_),
            write('- '),write(Fish),write(' '),write(Fish_name),nl)
    ;
        !),

    /*Tentukan Ranch*/
    (Ranch > 0 ->
        random(1,4,Ranch_type),
        (Ranch_type == 1 ->
            random(0,2,Milk_type),
            (Milk_type == 0 ->
                Ranch_id is 24, 
                write('- '),write(Ranch),write(' milk'),nl
            ;   
                Ranch_id is 25,
                write('- '),write(Ranch),write(' large milk'),nl
            )
        ;Ranch_type == 2 ->
            random(0,2,Wool_type),
            (Wool_type == 0 ->
                Ranch_id is 27, 
                write('- '),write(Ranch),write(' wool'),nl
            ;
                Ranch_id is 28, 
                write('- '),write(Ranch),write(' large wool'),nl
            )
        ;
            random(0,2,Egg_type),
            (Egg_type == 0 ->
                Ranch_id is 30,
                write('- '),write(Ranch),write(' egg'),nl
            ;
                Ranch_id is 31, 
                write('- '),write(Ranch),write(' large egg'),nl
            )
        )
    ;
        !),
    asserta(quest(Harvest_id,Harvest,Fish_id,Fish,Ranch_id,Ranch)).

displayQuest :-
    quest(Id_Harvest, Qty_Harvest, Id_Fish, Qty_Fish, Id_Ranch, Qty_Ranch),
    items(Id_Harvest, Name_Harvest,_,_,_,_,_,_),
    items(Id_Fish, Name_Fish,_,_,_,_,_,_),
    items(Id_Ranch, Name_Ranch,_,_,_,_,_,_),
    write('CURRENT QUEST'),nl,
    (Qty_Harvest > 0 ->
        write('- '),write(Qty_Harvest),write(' '),write(Name_Harvest),nl
    ;
        !),
    (Qty_Fish > 0 ->
        write('- '),write(Qty_Fish),write(' '),write(Name_Fish),nl
    ;
        !),
    (Qty_Ranch > 0 ->
        write('- '),write(Qty_Ranch),write(' '),write(Name_Ranch),nl
    ;
        !).

/* Finishing Quest */
fulfillQuest :-
    quest(Id_Harvest, Qty_Harvest, Id_Fish, Qty_Fish, Id_Ranch, Qty_Ranch),
    inventory(Id_Harvest,Name_Harvest,Qty_H,Sell_H,_,_,_,_),
    inventory(Id_Fish,Name_Fish,Qty_F,Sell_F,_,_,_,_),
    inventory(Id_Ranch,Name_Ranch,Qty_R,Sell_R,_,_,_,_),
    ((Qty_H >= Qty_Harvest, Qty_F >= Qty_Fish, Qty_R >= Qty_Ranch) ->
        displayQuest, write('Finish current quest?(y/n)'), read(X),
        (X == 'y' ->
            Reward_Harvest is Qty_H * Sell_H * 2,
            Reward_Fish is Qty_F * Sell_F * 2,
            Reward_Ranch is Qty_R * Sell_R * 2,
            Reward_Gold is Reward_Fish + Reward_Harvest + Reward_Ranch,
            Reward_Exp is 500,
	    write('Quest finished, you gain:),nl,write(Reward_Gold),write(' gold and '),write(Reward_Exp),write(' Exp'),
            player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
            Total_Gold is Reward_Gold + Gold,
            Total_Exp is Reward_Exp + Exp,
            retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
            asserta(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Total_Exp, Total_Gold))
            delItems(Name_Harvest,Qty_H),
            delItems(Name_Fish,Qty_F),
            delItems(Name_Ranch,Qty_R),
            retract(ongoing),
	        retract(quest(Id_Harvest, Qty_Harvest, Id_Fish, Qty_Fish, Id_Ranch, Qty_Ranch))
        ;
            !) 
    ;
        write('You have an on-going quest!')         
    ).

/* quest command */
quest :-
    map_quest(Q),map_object(XQ,YQ,Q),map_player(P),map_object(XP,YP,P),
    ((XQ =:= XP, YQ =:= YP) ->
        (ongoing ->
            fulfillQuest,!
        ;
            getQuest,
            assertz(ongoing),!
        )
    ;
        write('You are not on a "Quest" tile!'),!
    ).
