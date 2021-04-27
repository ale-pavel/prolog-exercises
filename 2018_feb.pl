/* Esercizio 2: sublist(?X, ?Y) = vero se X è una sottolista di Y, cioé quando ogni elemento di X è presente in Y, e per ogni coppia (x,y) in X essa compare nello stesso ordine in Y. */
/* member(?X, ?L) = vero se l'elemento X compare nella lista L */

sublist([], _).
%usare member è uno spreco computazionale, posso evitare questa istruzione
%sublist([X|_], Y) :- not(member(X, Y)), !, fail.
sublist([X|R1], [X|R2]) :- sublist(R1, R2).
sublist([X|R1], [_|R2]) :- sublist([X|R1], R2).


/* Test per verificare la correttezza del programma:
?- sublist(X, [a,b,c]).
X = [] ;
X = [a] ;
X = [a, b] ;
X = [a, b, c] ;
X = [a, c] ;
X = [b] ;
X = [b, c] ;
X = [c] ;
false.

?- sublist(X, [a,b,c]), length(X, 2).
X = [a, b] ;
X = [a, c] ;
X = [b, c] ;
false.

?- sublist([c,a], [a,b,c]).
false.

?- sublist([c,a], [a,b,c]).
false.

?- sublist([b,a|X], [a,b,c]).
false.

?- sublist([], [1]).
true.

?- sublist([1,3,5], [1,5]).
false.

%In questo ultimo test avviene un backtracking a qualche punto. Il risultato è corretto ma Prolog fornisce un'alternativa. Non sono riuscito a correggere con un cut dopo sublist(R1, R2).
?- sublist([1,3], [1,3]).
true;
false.

*/
