:- dynamic(exp/3).
:- dynamic(farmexp/3).
:- dynamic(fishexp/3).
:- dynamic(ranchexp/3).
:- dynamic(player/10).
:- dynamic(day/1).
:- dynamic(new/2).


/* Inisialisasi awal */
(exp(0,300,1)).
(farmexp(0, 100, 1)).
(fishexp(0, 100, 1)).
(ranchexp(0, 100, 1)).
player(_, 1, 1, 0, 1, 0, 1, 0, 0, 0).
day(0).

choose_job :- 
  write('Welcome to Harvest. Choose your job'), nl,
  write('1. Fisherman'), nl,
  write('2. Farmer'), nl,
  write('3. Rancher'), nl,
  write('> '), read(X),
  ((X =< 3) -> nl, ((X >= 1) ->
  ID is X-1, character(ID), true;
  write('That job does not exist! Please pick the listed jobs.'), nl, choose_job) ;
  nl, write('That job does not exist! Please pick the listed jobs.'), nl, choose_job), !.




character(ID) :-
  ID =:= 0 -> write('You choose Fisherman, let\'s start fishing'), 
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  assertz(player('fisherman', Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), !.
  

character(ID) :-  
  ID =:= 1 -> write('You choose Farmer, let\'s start farming'),
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  assertz(player('farmer', Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), !.
  

character(ID) :-
  ID =:= 2 -> write('You choose Rancher, let\'s start ranching'),
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  assertz(player('rancher', Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), !.
  
/* Add print Status */ 
status :- player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
          write('Your status: '), nl, 
          write('Job: '), write(Job), nl,
          write('Level: '), write(Level), nl,
          write('Level farming: '), write(FarmLevel), nl,
          write('Exp farming: '), write(FarmExp), nl,
          write('Level fishing: '), write(FishLevel), nl,
          write('Exp fishing: '), write(FishExp), nl,
          write('Level ranching: '), write(RanchLevel), nl,
          write('Exp ranching: '), write(RanchExp), nl,
          write('Exp: '), write(Exp), write('/'), exp(_,Max,_), write(Max), nl,
          write('Gold: '), write(Gold), nl.
/* Format Job */
job(0, 'Fisherman').
job(1, 'Farmer').
job(2, 'Rancher').



/* Implementasi Exp(X) */
levelUp(X) :-
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  NewLevel is Level + 1,
  assertz(player(Job, NewLevel, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)).

addExp(X) :-
  exp(PrevExp, Total, Level), NewExp is PrevExp + X,
  (X =:= 0 -> 
    write('You level up again!'), nl;
    format('You gain ~d exp ~n', [X])),
   (NewExp >= Total ->
    format('Level up! ~n', []),
    NewExp2 is NewExp-Total, NewLvl is Level + 1, NewTotal is 300 + (150 * NewLvl),
    retract(exp(PrevExp, Total, Level)), assertz(exp(NewExp2, NewTotal, NewLvl)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), 
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, NewExp2, Gold)),
    levelUp(Job),
    (NewExp2 >= NewTotal ->
      addExp(0)
    ;
      true
    )
  ;
    Expleft is Total-NewExp,
    format('You need ~d more exp to level up your overall level ~n', [Expleft]),
    retract(exp(PrevExp, Total, Level)), assertz(exp(NewExp, Total, Level)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, NewExp, Gold))
  ).

/* Buat Farmer */

levelUpFarm:-
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  NewFarmLevel is FarmLevel + 1,
  assertz(player(Job, Level, NewFarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)).

addFarmExp(X) :-
  farmexp(PrevExp, Total, FarmLevel), NewExp is PrevExp + X, 
  (X =:= 0 -> 
    write('You level up again!'), nl;
    format('You gain ~d farming exp ~n', [X])),
  (NewExp >= Total ->
    format('Level up! ~n', []),
    NewExp2 is NewExp-Total, NewLvl is FarmLevel + 1, NewTotal is (100 * NewLvl),
    retract(farmexp(PrevExp, Total, FarmLevel)), assertz(farmexp(NewExp2, NewTotal, NewLvl)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), 
    assertz(player(Job, Level, FarmLevel, NewExp2, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    levelUpFarm,
    (NewExp2 >= NewTotal ->
      addFarmExp(0)
    ;
      true
    )
  ;
    Expleft is Total-NewExp,
    format('You need ~d more exp to level up your farming level ~n', [Expleft]),
    retract(farmexp(PrevExp, Total, FarmLevel)), assertz(farmexp(NewExp, Total, FarmLevel)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    assertz(player(Job, Level, FarmLevel, NewExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold))
  ).

/* Buat Fisherman */

levelUpFish:- 
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  NewFishLevel is FishLevel + 1,
  assertz(player(Job, Level, FarmLevel, FarmExp, NewFishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)).

addFishExp(X) :-
  fishexp(PrevExp, Total, FishLevel), NewExp is PrevExp + X, 
  (X =:= 0 -> 
    write('You level up again!'), nl;
    format('You gain ~d fishing exp ~n', [X])),
  (NewExp >= Total ->
    format('Level up! ~n', []),
    NewExp2 is NewExp-Total, NewLvl is FishLevel + 1, NewTotal is (100 * NewLvl),
    retract(fishexp(PrevExp, Total, FishLevel)), assertz(fishexp(NewExp2, NewTotal, NewLvl)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), 
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, NewExp2, RanchLevel, RanchExp, Exp, Gold)),
    levelUpFish,
    (NewExp2 >= NewTotal ->
      addFishExp(0)
    ;
      true
    )
  ;
    Expleft is Total-NewExp,
    format('You need ~d more exp to level up your fishing level ~n', [Expleft]),
    retract(fishexp(PrevExp, Total, FishLevel)), assertz(fishexp(NewExp, Total, FishLevel)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, NewExp, RanchLevel, RanchExp, Exp, Gold))
  ).

/* Buat rancher */
levelUpRanch:- 
  player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
  retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
  NewRanchLevel is RanchLevel + 1,
  assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, NewRanchLevel, RanchExp, Exp, Gold)).

addRanchExp(X) :-
  ranchexp(PrevExp, Total, RanchLevel), NewExp is PrevExp + X, 
  (X =:= 0 -> 
    write('You level up again!'), nl;
    format('You gain ~d ranching exp ~n', [X])),
  (NewExp >= Total ->
    format('Level up! ~n', []),
    NewExp2 is NewExp-Total, NewLvl is RanchLevel + 1, NewTotal is (100 * NewLvl),
    retract(ranchexp(PrevExp, Total, RanchLevel)), assertz(ranchexp(NewExp2, NewTotal, NewLvl)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), 
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, NewExp2, Exp, Gold)),
    levelUpRanch,
    (NewExp2 >= NewTotal ->
      addRanchExp(0)
    ;
      true
    )
  ;
    Expleft is Total-NewExp,
    format('You need ~d more exp to level up your ranching level ~n', [Expleft]),
    retract(ranchexp(PrevExp, Total, RanchLevel)), assertz(ranchexp(NewExp, Total, RanchLevel)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, NewExp, Exp, Gold))
  ).
