:- include('items.pl').
:- dynamic(inventory/8).    

inventoryCap(100).
sumList([], 0).

sumList([Head|Tail], Sum) :-
    sumList(Tail,Sum2),
    Sum is Head + Sum2.

inventoryQty(Quantity) :-
    findall(Qty, inventory(_,_,Qty,_,_,_,_,_), QtyList),
    sumList(QtyList,Quantity).

/* item baru */
addItems(ItemName,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    \+inventory(_,ItemName,_,_,_,_,_,_),
    items(ID,ItemName,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
	format('+~w ~w!', [Quantity, ItemName]),!.
	
addItems(ItemID,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    \+inventory(ItemID,_,_,_,_,_,_,_),
    items(ItemID,ItemName,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ItemID,ItemName,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, ItemName]),!.

/* tambah quantity item lama */
addItems(ItemName,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty + Quantity,
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, ItemName]),!.
	
addItems(ItemID,Quantity) :-
    inventoryCap(Max),
    inventoryQty(Length),
    Length + Quantity =< Max,
    inventory(ItemID,_,Qty,_,_,_,_,_),
    Qty2 is Qty + Quantity,
    retract(inventory(ItemID,Name,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    asserta(inventory(ItemID,Name,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    format('+~w ~w!', [Quantity, Name]),!.

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
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
	format('Inventory full!, only +~w ~w!', [QtyAvailable, ItemName]),!.

/* throwqty < qty */
delItems(ItemName,Quantity) :-
    inventory(_,ItemName,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 > 0,
    retract(inventory(ID,ItemName,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    asserta(inventory(ID,ItemName,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),!.
	
delItems(ItemID,Quantity) :-
    inventory(ItemID,_,Qty,_,_,_,_,_),
    Qty2 is Qty - Quantity,
    Qty2 > 0,
    retract(inventory(ItemID,Name,Qty,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),
    asserta(inventory(ItemID,Name,Qty2,Sell,Buy,FishLevel,FarmLevel,RanchLevel)),!.

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

printItem([],[]).
printItem([A|X],[B|Y]) :-
	format('~w ~w ~n', [B, A]),
    printItem(X,Y).
	
displayInventory :-
    makeListItems(ListNama,ListQuantity),
    printItem(ListNama,ListQuantity).

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
	( ThrowQty > Qty
	-> format('You dont have enough ~w. Cancelling...', [ItemName])
	; delItems(ItemName, ThrowQty),
	format('You threw away ~w ~w.', [ThrowQty, ItemName])).
	