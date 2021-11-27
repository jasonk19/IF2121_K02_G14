exit :- 
    write('Do you want to exit the game?(y/n)'),nl,read(X),
    (X == 'y' ->
        write('Thanks for playing'),nl
    ;
        !).

/* periksa tiap kali nambah waktu atau nambah gold */
goalCheck :-
    player(_,_,_,_,_,_,_,_,_, Gold),
    /* time masih placeholder */
    Time is 200, 
    (Gold >= 20000 ->
        write('Congratulations, you have collected 20000 golds!')
    ;
        (Time >= 100 ->
            write('You failed!')
        ;
            !)).
