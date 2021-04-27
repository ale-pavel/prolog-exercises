/* Definire un predicato Prolog complemento(+Set,+Subset,-C) che, assumendo
che Set e Subset siano liste senza ripetizioni, abbia successo
quando C è una lista che rappresenta il complemento di Subset rispetto a
Set. Il predicato fallisce se Subset contiene qualche elemento che non ap-
partiene a Set. Ad esempio, complemento([1,2,3,4,5,6],[2,4,6],C)
avrà successo istanziando C alla lista [1,3,5] (o una sua permutazione),
mentre complemento([1,2,3,4,5,6],[2,4,7],C) fallisce. */
/* Suggerimento: definire il predicato per ricorsione su Subset. Può essere
utile fare ricorso al predicato predefinito select(?Elem,?List,?Newlist)
che ha successo quando Newlist è uguale alla lista che si ottiene da List
eliminando un’occorrenza di Elem. Il predicato fallisce se Elem non occorre
in List. */

complemento(Set, [], Set).
complemento(Set, [X|Rest], Result) :-
	select(X, Set, Removed), complemento(Removed, Rest, Result).

/* Test effettuati
   
?- complemento([1,2,3,4,5,6],[2,4,6],C).
C = [1, 3, 5]
   
?- complemento([1,2,3,4,5,6],[2,4,7],C).
false.

?- complemento([], [], C).
C = [] ;
false.

?- complemento([1,2,3], [], C).
C = [1, 2, 3] ;
false.

?- complemento([], [1,2], C).
false.
   
*/

/* Per esercizio mi ridefinisco select(?Elem,?List,?Newlist) */
select2(Elem, [Elem|Rest], Rest) :- !.
select2(Elem, [X|Rest], [X|Result]) :- select2(Elem, Rest, Result).

