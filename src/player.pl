:- dynamic(exp/3).
:- dynamic(player/10).
:- dynamic(equipment/2).
/* Job, specific job level, specific job exp */
/* Kalo semisal terlalu kecil atau terlalu besar bisa diubah nantinya */
growthRate(farmer, 1, 20).
growthRate(fisherman, 1, 30).
growthRate(rancher, 1, 20).

/* Entrystat saat masih level 1*/
/* Format: Job, specific job level, specific job exp, exp, gold */
entryStat(farmer, 1, 56, 0, 1000).
entryStat(fisherman, 1, 76, 0, 1000).
entryStat(rancher, 1, 56, 0, 1000).

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
  ID =:= 0 -> write('You choose Fisherman, let\'s start fishing').
  /* Add Fisherman status */
character(ID) :-    
  ID =:= 1 -> write('You choose Farmer, let\'s start farming').
  /* Add Farmer status */
character(ID) :-
  ID =:= 2 -> write('You choose Rancher, let\'s start ranching').
  /* Add Rancher status */

/* Add print Status */ 
status :- player(Job, Level, FarmLevel, FarmExp, FishLevel, FishExp, RanchLevel, RanchExp, Exp, Gold),
            equipment(Farming, Fishing),
            write('Your status: '), nl, 
            write('Job: '), write(Job), nl,
            write('Level: '), write(Level), nl,
            write('Level farming: '), write(FarmLevel), nl,
            write('Exp farming: '), write(FarmExp), nl,
            write('Level fishing: '), write(FishLevel), nl,
            write('Exp fishing: '), write(FishExp), nl,
            write('Level ranching: '), write(RanchLevel), nl,
            write('Exp ranching: '), write(RanchExp), nl,
            write('Exp: '), write(Exp), , write('/'), exp(_,Max,_), write(Max), nl,
            write('Gold: '), write(Gold), nl.

/* Format Job */
job(0, 'Fisherman').
job(1, 'Farmer').
job(2, 'Rancher').