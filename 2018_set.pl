/* Esercizio 2: Dati alberi binari rappresentati con empty (albero vuoto) e t(X,T1,T2) (con sottoalberi T1 e T2, e radice X) definire:
   foglie(+Tree, -Foglie) = Foglie è la lista di foglie dell'albero binario Tree (ordine e ripetizioni non importanti). */
/* append(?L1, ?L2, ?L) = L è la lista ottenuta concatenando L1 ed L2. */

foglie(empty, []).
foglie(t(X, empty, empty), [X]) :- !.
foglie(t(_, T1, T2), Result) :-
	foglie(T1, Left), foglie(T2, Right), append(Left, Right, Result).


/* Albero di esempio (potrei usare albero(...) e richiamarlo con albero(X):
 t(a, t(b,t(c,empty,empty),t(d,empty,empty)), t(c,empty,t(d,empty,empty))) */
/* Test di verifica programma:

?- foglie(t(a, t(b,t(c,empty,empty),t(d,empty,empty)), t(c,empty,t(d,empty,empty))), Foglie).
Foglie = [c, d, d].

?- foglie(t(a,empty,t(b,t(c,empty,empty),empty)), Result).
Result = [c].

?- foglie(empty, Result).
Result = [].
   
%Senza il cut vengono mostrate altre strade percorribili dal backtracking, in cui però alcune foglie corrette per la soluzione sono in rami che non le aggiungeranno a Foglie.
?- foglie(t(a, t(b,t(c,empty,empty),t(d,empty,empty)), t(c,empty,t(d,empty,empty))), Foglie).
Foglie = [c, d, d] ;
Foglie = [c, d] ;
Foglie = [c, d] ;
Foglie = [c] ;
Foglie = [d, d] ;
Foglie = [d] ;
Foglie = [d] ;
Foglie = [].

*/