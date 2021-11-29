exit :- 
    write('Do you want to exit the game?(y/n)'),nl,read(X),
    (X == 'y' ->
        write('Thanks for playing'),nl
    ;
        !).

/* periksa tiap kali nambah waktu atau nambah gold */
goalCheck :-
    player(_,_,_,_,_,_,_,_,_, Gold),
    day(Time), 
    (Gold >= 20000 ->
        write('Congratulations, you have collected 20000 golds!')
    ;
        (Time >= 100 ->
            write('----------------------------GAME OVER---------------------------'),nl,
            write('It is already one year but you have failed to collect 20000 gold'),
        ;
            !)).
