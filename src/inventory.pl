:- include('items.pl').
:- dynamic(inventory/8).    

inventoryCap(100).

inventoryQty(Quantity) :-
    findall(Qty, inventory(_,_,Qty,_,_,_,_,_), ListofQty),
    sumList(ListofQty,Quantity).

sumList([], 0).
sumList([Head|Tail], Sum) :-
   sumList(Tail,Sum1),
   Sum is Head + Sum1.

/* item baru */
addItems(ItemName,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    \+inventory(_,ItemName,_,_,_,_,_,_),
    items(ID,ItemName,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
	format('+~w ~w!', [Quantity, ItemName]),!.
	
addItems(ItemID,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    \+inventory(ItemID,_,_,_,_,_,_,_),
    items(ID,ItemName,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, ItemName]),!.

/* tambah quantity item lama */
addItems(ItemName,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty + Quantity,
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, ItemName]),!.
	
addItems(ItemID,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    inventory(ItemID,_,Qty,_,_,_,_,_),
    Qty2 is Qty + Quantity,
    retract(inventory(ItemID,Name,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    asserta(inventory(ItemID,Name,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, ItemID]),!.

/* full */
addItems(_,_) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length = Max,
    write('Inventory full!'),!,fail.

/* overload */
addItems(ItemName,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity > Max,
    QtyAvailable is Max - Length,
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty + QtyAvailable,
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
	format('Inventory full!, only +~w ~w!', [QtyAvailable, ItemName]),!.

/* throwqty < qty */
delItems(ItemName,Quantity) :-
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 > 0,
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),!.
	
delItems(ItemID,Quantity) :-
    inventory(ItemID,_,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 > 0,
    retract(inventory(ItemID,Name,Qty,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),
    asserta(inventory(ItemID,Name,Qty2,Sell,Buy,FarmLevel,FishLevel,RanchLevel)),!.

/* throwqty = qty */
delItems(ItemName,Quantity) :-
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 =:= 0,
    retract(inventory(_,ItemName,Qty,_,_,_,_,_)),!.
delItems(ItemID,Quantity) :-
    inventory(ItemID,_,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 =:= 0,
    retract(inventory(ItemID,_,Qty,_,_,_,_,_)),!.
	
makeListItems(ListNama, ListQuantity) :-
    findall(Nama, inventory(_,Nama,_,_,_,_,_,_), ListNama),
    findall(Quantity, inventory(_,_,Quantity,_,_,_,_,_), ListQuantity).

stt2([],[]).
stt2([A|X],[B|Y]) :-
	format('~w ~w ~n', [B, A]),
    stt2(X,Y).
	
displayInventory :-
    makeListItems(ListNama,ListQuantity),
    stt2(ListNama,ListQuantity).

inventory :- 
	inventoryQty(Qty),
	inventoryCap(Max),
	format('~nYour inventory (~w / ~w)~n', [Qty, Max]),
	displayInventory.

throwItem :- 
	nl, write('Your inventory'),nl,
	displayInventory, nl,
	write('What do you want to throw?'), nl,
	write('> '), read(ItemName), nl,
	inventory(_,ItemName,Qty,_,_,_,_,_),
	format('You have ~w ~w. How many do you want to throw?~n', [Qty, ItemName]),
	write('> '), read(ThrowQty), nl,
	delItems(ItemName, ThrowQty),
	format('You threw away ~w ~w.', [ThrowQty, ItemName]).
	
