:- include('map.pl').
:- dynamic(diary/2).
:- include('player.pl').

addDiary(Day, DiaryContent) :-
  asserta(diary(Day, DiaryContent)).

makeListDiary(DiaryDay) :-
  findall(Day, diary(Day,_), DiaryDay).

func([]).
func([A|X]) :-
  format('- Day ~w ~n', [A]),
  func(X).

displayDiary :-
  makeListDiary(DiaryDay),
  func(DiaryDay).


house :-
  map_player(P), map_object(X,Y,P,_),
  map_house(H), map_object(XH,YH,H,_),
  (X =:= XH -> (Y =:= YH -> assertz(inHouse), write('You have entered your House, input "exitHouse" to exit House'), nl,welcomeHouse, ! ; write('You are not at your House!'), !) ; write('You are not at your House!'), !).

exitHouse :-
  (inHouse -> retract(inHouse), write('You have left your House') ; write('You are not at your House!')).

welcomeHouse :- 
  write('What do you want to do? '), nl,
  write('- sleep'), nl,
  write('- writeDiary'), nl,
  write('- readDiary'), nl,
  write('- exitHouse'), nl.

sleep :- 
  (inHouse -> write('You went to sleep'), addDaySleep(Y), goalCheck, nl,
  nl, 
  write('Day '), day(X), write(X), nl,
  planted(_,_,_,Time), NTime is 0, retractall(planted(_,_,_,Time)), asserta(planted(_,_,_,NTime)), !); 
  write('You cannot sleep outside the house'), !.

addDaySleep(Y) :-
  day(X), Y is X + 8, retract(day(X)), assertz(day(Y)).

writeDiary :-
  inHouse,
  day(Day),
  write('Write your diary for Day '), write(Day), nl,
  read(X), nl, 
  addDiary(Day, X), 
  write('Day '), write(Day), write(' entry saved'), !; 
  write('You cannot write diary outside the house'), nl.

readDiary :-
  inHouse, 
  write('Here are the list of your entries: '), nl,
  displayDiary, nl,
  write('Which entry do you want to read?'), nl,
  read(X), process(X), !; write('You cannot write diary outside the house').

process(X) :-
  makeListDiary(DiaryDay),
  member(X, DiaryDay),
  diary(X,Content),
  write('Here\'s your entry for day '), write(X), write(':'), nl,
  write(Content), nl, !; write('No entry for day '), write(X), !.


