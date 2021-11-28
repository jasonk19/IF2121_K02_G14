startGame :- 
  ['./message.pl'],
  ['./map.pl'],
  ['./move.pl'],
  ['./farming.pl'],
  intro,
  introMsg,
  map_structure,
  init_player_pos.

start :-
  choose_job.

