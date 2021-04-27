/* Una funzione parziale f definita sull’insieme finito di elementi {X1, ..., Xn}
e tale che, per i∈{1, ..., n}, f(Xi)=Vi si può rappresentare mediante
una lista di coppie [(X1,V1),...,(Xn,Vn)]. Definire un predicato Prolog
assoc(?X,+Lista,?V) vero se il valore di X secondo la funzione parziale
rappresentata da Lista è V. Se X e/o V non sono istanziati, il backtracking
fornirà tutti i valori che rendono vero il predicato. */
/* Ad esempio, per il goal assoc(X,[(b,2),(a,1),(c,3),(d,2)],2),
il Prolog darà le soluzioni (i) X = b e (ii) X = d.
Per il goal assoc(X,[(b,2),(a,1)],V) le soluzioni fornite saranno:
(i) X = b, V = 2 e (ii) X = a, V = 1. */

%questa clausola non deve esserci: se la lista è vuota non ci sono associazioni, quindi fail
%assoc(_, [], _).
assoc(X, [(X,V)|_], V).
assoc(X, [(_,_)|Rest], V) :- assoc(X, Rest, V). 

/* Test eseguiti:

?- assoc(X,[(b,2),(a,1),(c,3),(d,2)],2).
X = b ;
X = d ;
true.

?- assoc(X,[(b,2),(a,1)],V).
X = b,
V = 2 ;
X = a,
V = 1 ;
true.

*/
