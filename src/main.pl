startGame :- 
  ['./message.pl'],
  ['./map.pl'],
  ['./move.pl'],
  ['./farming.pl'],
  ['./quest.pl'],
  ['./end.pl'],
  ['./inventory.pl'],
  intro,
  introMsg,
  map_structure,
  init_player_pos,
  assertz(day(0)).

start :-
  choose_job.

