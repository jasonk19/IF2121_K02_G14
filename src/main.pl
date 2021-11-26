startGame :- 
  ['./message.pl'],
  ['./player.pl'],
  ['./map.pl'],
  ['./move.pl'],
  ['./farming.pl'],
  ['./quest.pl'],
  intro,
  introMsg,
  map_structure,
  init_player_pos.

start :-
  choose_job.

