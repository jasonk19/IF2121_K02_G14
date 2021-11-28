:- dynamic(exp/3).
:- dynamic(player/10).
:- dynamic(equipment/2).
/* Job, specific job exp */
/* Kalo semisal terlalu kecil atau terlalu besar bisa diubah nantinya */
growthRate(farmer, 200).
growthRate(fisherman, 300).
growthRate(rancher, 200).

/* Entrystat saat masih level 1*/
/* Format: Job, specific job level, specific job exp, exp, gold */
entryStat(farmer, 1, 56, 0, 1000).
entryStat(fisherman, 1, 76, 0, 1000).
entryStat(rancher, 1, 56, 0, 1000).

/* exp(currentExp, TotalExp, Lvl) */

entryExp :- 
  retractall(exp(_,_,_)),
  assertz(exp(0,300,1)).


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
  entryStat('fisherman', FishermanLvl, FishermanExp, Exp, Gold),
  entryStat('farmer', FarmerLvl, FarmerExp, _,_),
  entryStat('rancher', RancherLvl, RancherExp, _,_),
  entryExp,
  assertz(player('fisherman', 1, FarmerLvl, FarmerExp, FishermanLvl, FishermanExp, RancherLvl, RancherExp, Exp, Gold)).
  

character(ID) :-    
  ID =:= 1 -> write('You choose Farmer, let\'s start farming'),
  entryStat('fisherman', FishermanLvl, FishermanExp, Exp, Gold),
  entryStat('farmer', FarmerLvl, FarmerExp, _,_),
  entryStat('rancher', RancherLvl, RancherExp, _,_),
  entryExp,
  assertz(player('farmer', 1, FarmerLvl, FarmerExp, FishermanLvl, FishermanExp, RancherLvl, RancherExp, Exp, Gold)).
  

character(ID) :-
  ID =:= 2 -> write('You choose Rancher, let\'s start ranching'),
  entryStat('fisherman', FishermanLvl, FishermanExp, Exp, Gold),
  entryStat('farmer', FarmerLvl, FarmerExp, _,_),
  entryStat('rancher', RancherLvl, RancherExp, _,_),
  entryExp,
  assertz(player('rancher', 1, FarmerLvl, FarmerExp, FishermanLvl, FishermanExp, RancherLvl, RancherExp, Exp, Gold)).
  
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
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)), assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, NewExp2, Gold)),
    levelUp(Job),
    (NewExp2 >= NewTotal ->
      addExp(0)
    ;
      true
    )
  ;
    Expleft is Total-NewExp,
    format('You need ~d more exp to level up ~n', [Expleft]),
    retract(exp(PrevExp, Total, Level)), assertz(exp(NewExp, Total, Level)),
    player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
    retract(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold)),
    assertz(player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, NewExp, Gold))
  ).