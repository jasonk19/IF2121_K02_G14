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
  ID =:= 0, 
  write('You choose Fisherman, let\'s start fishing');
  /* Add Fisherman status */
character(ID) :-    
  ID =:= 1 -> write('You choose Farmer, let\'s start farming');
  /* Add Farmer status */
character(ID) :-
  ID =:= 2 -> write('You choose Rancher, let\'s start ranching').
  /* Add Rancher status */

/* Format Job */
job(0, 'Fisherman').
job(1, 'Farmer').
job(2, 'Rancher').