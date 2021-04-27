/* http://cialdea.dia.uniroma3.it/teaching/logica/slides/2-prolog/Esercizi.pdf */

/*1. Implementare il proprio “albero genealogico”, definendo (mediante fatti)
la relazione genitore (fino ai bisnonni, con tutti gli zii e i cugini). Definire
poi i predicati a due argomenti: fratello (che rappresenti sia la relazione
fratello che sorella), nonno (nonno o nonna), zio (zio o zia), cugino
(cugino o cugina) e discendente. */
/* Albero genealogico rappresentato (con |--X1, X1 è il figlio dei due sopra e sotto il | )
x0 -- x1
	   |-- y1 
      X2    |
			|--- z1
      x3    |
       |-- y2
       |
       |-- y3 -- z2
      x4
*/
genitore(x0, x1). %x0 bisnonno di z1
genitore(x1, y1).
genitore(x2, y1).
genitore(x3, y2).
genitore(x4, y2).
genitore(x3, y3).
genitore(x4, y3).
genitore(y1, z1).
genitore(y2, z1).
genitore(y3, z2).

%molti dei predicati definiti riportano soluzioni duplicate (risolvere con cut?)
fratello(X, Y) :- genitore(Z, X), genitore(Z, Y).
nonno(X, Y) :- genitore(X, Z), genitore(Z, Y).
zio(X, Y) :- fratello(Z, X), genitore(Z, Y).
cugino(X, Y) :- zio(Z, X), genitore(Z, Y).
discendente(X, Y) :- genitore(Y, X).
discendente(X, Y) :- genitore(Y, Antenato), discendente(X, Antenato).


/*2. Definire un predicato fact(+X,?Y), vero se Y è il fattoriale di X. */
fact(0, 1) :- !.
%fact(1, 1).
fact(X, Result) :- Y is X-1, fact(Y, Fact), Result is X*Fact.


/*3. Definire il predicato palindroma(X), vero se X è una lista palindroma
(se la lista viene letta in un verso o nell’altro si ottiene la stessa sequenza
di elementi). Ad esempio [a,b,c,b,a] è palindroma, [a,b,c,a] non lo è. */
%Inverte una lista dall'ultimo al primo elemento.
%reverse([], []).
reverse([X], [X]) :- !.
reverse([X|Rest], Result) :- reverse(Rest, RevRest), append(RevRest, [X], Result).

%palindroma([]).
%palindroma([X]).
%palindroma([X|Rest]) :- reverse([X|Rest], [X|RevRest]).
palindroma(L) :- reverse(L, L).


/*4. Definire un predicato maxlist(+L,?N) (dove L è una lista di numeri),
vero se N è il massimo elemento della lista L. Fallisce se L è vuota. */
maxlist([X], X).
maxlist([X|Rest], X) :- maxlist(Rest, PrevMax), X>PrevMax, !.
maxlist([_|Rest], PrevMax) :- maxlist(Rest, PrevMax).


/*5. Avendo definito pari(X), definire il predicato split(+L,?P,?D) = soddisfatto se 
L è una lista di interi, P è la lista contenente tutti gli elementi pari di L e D 
tutti quelli dispari (nello stesso ordine in cui occorrono in L).*/
pari(X) :- 0 is X mod 2.

split([], [], []).
split([X|Rest], [X|RP], RD) :- pari(X), !, split(Rest, RP, RD).
split([X|Rest], RP, [X|RD]) :- split(Rest, RP, RD).

split2([],[],[]).
split2([X|Rest], [X|RP], RD) :- pari(X), split2(Rest, RP, RD).
split2([X|Rest], RP, [X|RD]) :- not(pari(X)), split2(Rest, RP, RD).

/* Non sono riuscito a far funzionare la versione con l'or per abbreviare in una clausola sola */
/*split3([],[],[]).
split3([X|Rest], P, D) :- 
	(pari(X), P=[X|RP], split3(Rest, RP, RD)); 
	(not(pari(X)), D=[X|RD], split3(Rest, RP, RD)).

split4([],[],[]).
split4([X|Rest], P, D) :- 
	(pari(X), !, P=[X|RP], split4(Rest, RP, RD)); 
	(D=[X|RD], split4(Rest, RP, RD)).*/



/*6. (TODO) Scrivere un programma che risolva il problema delle torri di Hanoi (troppo complicato, vedere slide) */



/*7. Definire un predicato prefisso(Pre,L) = la lista Pre è un prefisso della lista L. Ad esempio, i prefissi della lista [1,2,3] sono: la lista vuota [] e le liste [1], [1,2] e [1,2,3] stessa.*/
prefisso([], _).
prefisso([X|R1], [X|R2]) :- prefisso(R1, R2).

prefisso2(Pre, L) :- append(Pre, _, L).


/*8. Definire un predicato suffisso(Suf,L) = la lista Suf è un suffisso della lista L. Ad esempio, i suffissi della lista [1,2,3] sono: la lista vuota [] e le liste [3], [2,3] e [1,2,3] stessa.*/
/*suffisso([X|R1], []) :- !, fail. %non serve, implicitamente falso*/
suffisso([X|R1], [X|R2]) :- length(R1, N), length(R2, N), !, suffisso(R1, R2).
suffisso([X|R1], [_|R2]) :- suffisso([X|R1], R2).
suffisso([], _).

suffisso2(Suf, L) :- append(_, Suf, L).

suffisso3(Suf, Suf).
suffisso3(Suf, [_|Rest]) :- suffisso3(Suf, Rest).


/*9. Definire un predicato sublist(S,L) = S è una sottolista di L costituita da
elementi contigui in L. Ad esempio, le sottoliste di [1,2,3] sono: la lista vuota [] e le liste [1], [2], [3], [1,2], [2,3] e [1,2,3] stessa.*/
sublist(L1, L2) :- sublist(L1, L1, L2).
sublist(L1, [X|R1], [X|R2]) :- sublist(L1, R1, R2), !.
sublist(L1, [_|_], [_|R2]) :- sublist(L1, R2), !.
sublist(_, [], _).

sublist2(Sub, L) :- append(_, Sub, X), append(X, _, L).

sublist3(Sub, L) :- suffisso2(X, L), prefisso2(Sub, X).
sublist4(Sub, L) :- append(_, X, L), append(Sub, _, X).


/*10. Definire i seguenti predicati (vedi slide, sono 7 predicati)*/
/*(a)*/
subset([], _).
subset([X|Sub], Set) :- member(X, Set), !, subset(Sub, Set).

/*(b)*/
rev([], []).
rev([X|Rest], Rev) :- rev(Rest, RestRev), append(RestRev, [X], Rev).

/*(c)*/
del_first(X, [X|L], L) :- !.
del_first(X, [Y|L], [Y|Resto]) :- del_first(X, L, Resto).

/*(d)*/
del(X, L, L) :- not(member(X, L)), !.
del(X, [X|L], Resto) :- !, del(X, L, Resto).
del(X, [Y|L], [Y|Resto]) :- del(X, L, Resto).

/*(e)*/
%subst(_, _, [], []).
subst(X, _, L, L) :- not(member(X, L)), !.
subst(X, Y, [X|Rest], [Y|RestNuova]) :- subst(X, Y, Rest, RestNuova), !.
subst(X, Y, [Z|Rest], [Z|RestNuova]) :- subst(X, Y, Rest, RestNuova).

/*(f)*/
mkset([], []).
%Problema di global stack trace exceeded con member(X,Set)
mkset([X|Rest], Set) :- member(X, Rest), !, mkset(Rest, Set).
mkset([X|Rest], [X|Set]) :- mkset(Rest, Set).

/*(g)*/
/*Supponendo che le liste in input non abbiano ripetizioni*/
%union(A, B, Union) :- (A=[], Union=B) ; (B=[], Union=A).
union(A, B, Union) :- append(A, B, App), mkset(App, Union).

union2([], B, B).
union2([X|RestA], B, Union) :- member(X, B), !, union2(RestA, B, Union).
union2([X|RestA], B, [X|Union]) :- union2(RestA, B, Union).


/* 11. Definire un predicato cartprod(+A,+B,-Set), vero se A e B sono liste
e Set una lista di coppie che rappresenta il prodotto cartesiano di A e B.
Ad esempio:
   ?- cartprod([a,b,c],[1,2],Set).
   Set = [ (a, 1), (a, 2), (b, 1), (b, 2), (c, 1), (c, 2)]. */

cartprod(L1, L2, Set) :- cartprod(L1, L2, L2, Set).
cartprod([], [], _, []).
cartprod([], L2, L2, []).
cartprod([_|R1], [], L2, Set) :- cartprod(R1, L2, L2, Set).
cartprod([X|R1], [Y|R2], L2, [(X,Y)|Set]) :- cartprod([X|R1], R2, L2, Set).

%Soluzione con l'intuizione del predicato accoppia (visto a lezione)
accoppia(_, [], []).
accoppia(X, [Y|Rest], [(X,Y)|Result]) :- accoppia(X, Rest, Result).

cartprod2([], _, []).
cartprod2(_, [], []).
cartprod2([X|R1], L2, Result) :- 
	accoppia(X, L2, Coppie), cartprod2(R1, L2, Set),
	append(Coppie, Set, Result).


/* 12. Definire un predicato insert(X,L1,L2), vero se L2 si ottiene inserendo X
in L1 (in qualsiasi posizione). Almeno una delle due liste L1 e L2 devono
essere istanziate. Ad esempio:
?- insert(a,[1,2],X).
X = [a, 1, 2] ;
X = [1, a, 2] ;
X = [1, 2, a] ;
false.
?- insert(a,X,[1,a,2]).
X = [1, 2] ;
false.*/
%Il cut è necessario per evitare una soluzione duplicata in fondo. Ragionandoci sopra l'intera clausola è superflua dato che è dimostrabile tramite la seconda
%insert(X, [], [X]) :- !.
insert(X, L, [X|L]).
insert(X, [Y|Rest], [Y|Result]) :- insert(X, Rest, Result).


/* 13. Definire un predicato permut(X,Y) vero se X e Y sono liste e Y è una
permutazione di X (senza usare il predicato predefinito permutation/2).
Ad esempio:
?- permut([1,2,3],Permut).
Permut = [1, 2, 3] ;
Permut = [2, 1, 3] ;
Permut = [2, 3, 1] ;
Permut = [1, 3, 2] ;
Permut = [3, 1, 2] ;
Permut = [3, 2, 1] ;
false. */
permut([], []).
permut([X|Rest], Result) :- permut(Rest, Permut), insert(X, Permut, Result).


/* 14. */
/* Definire un predicato search subset(+IntList,+N,?Set), dove IntList
`e una lista di interi positivi e N un intero positivo, che sia vero se Set
`e una lista rappresentante un sottoinsieme di IntList, tale che la somma
degli elementi in Set `e uguale a N. Si pu`o assumere che IntList sia senza
ripetizioni. Ad esempio:
?- search_subset([4,8,5,3,9,6,7],9,Subset).
Subset = [4, 5] ;
Subset = [3, 6] ;
Subset = [9] ;
false. */
search_subset([], 0, []).
search_subset([X|Rest], Sum, [X|Subset]) :- PrevSum is Sum-X, search_subset(Rest, PrevSum, Subset).
%search_subset([X|Rest], Sum, [X|Subset]) :- search_subset(Rest, PrevSum, Subset), Sum is PrevSum+X.
search_subset([_|Rest], PrevSum, Subset) :- search_subset(Rest, PrevSum, Subset). 


/* 15. Conveniamo di rappresentare gli alberi binari usando l’atomo empty per
l’albero vuoto e strutture della forma t(Root,Left,Right) per alberi con
radice Root, sottoalbero sinistro Left e sottoalbero destro Right. Definire
i predicati: */
albero(t(a, t(b,t(c,empty,empty),t(d,empty,empty)), t(c,empty,t(d,empty,empty)))).

/* (a) height(+T,?N) = N `e l’altezza dell’albero T. Il predicato fallisce
se T `e l’albero vuoto. */
height(empty, 0).
height(t(_, Left, Right), N) :- height(Left, L), height(Right, R), L>=R, !, N is L+1.
height(t(_, _, Right), N) :- height(Right, R), N is R+1.

/* (b) reflect(T,T1) = T `e l’immagine riflessa di T1. Almeno uno tra T e
T1 devono essere completamente istanziati. */
reflect(empty, empty).
reflect(t(E, Left, Right), t(E, RRef, LRef)) :- reflect(Left, LRef), reflect(Right, RRef).

/* (c) size(+T,?N) = N `e il numero di nodi dell’albero T. */
size(empty, 0).
size(t(_, Left, Right), N) :- size(Left, L), size(Right, R), N is L+R+1.

/* (d) labels(+T,-L) = L `e una lista di tutte le etichette dei nodi di T.
Se diversi nodi di T hanno la stessa etichetta, la lista L conterr`a
ripetizioni dello stesso elemento. Gli elementi di L possono occorrere
in qualsiasi ordine. */
labels(empty, []).
labels(t(Elem, Left, Right), [Elem|Result]) :- labels(Left, L), labels(Right, R), append(L, R, Result).

/* (e) branch(+T,?Leaf,?Path) = Path `e una lista che rappresenta un
ramo dalla radice di T fino a una foglia etichettata da Leaf. */
branch(t(Leaf, empty, empty), Leaf, [Leaf]) :- !.
branch(t(Elem, Left, _), Leaf, [Elem|Path]) :- branch(Left, Leaf, Path).
branch(t(Elem, _, Right), Leaf, [Elem|Path]) :- branch(Right, Leaf, Path).


/* 16. Un grafo si pu`o rappresentare mediante un insieme di fatti della forma
arc(X,Y), che definiscono la relazione binaria “esiste un arco da X a Y”.
Ad esempio:
arc(a,b).
arc(a,e).
arc(b,a).
arc(b,c).
arc(c,c).
arc(c,d).
arc(d,c).
arc(d,b).
arc(e,c).
Definire un predicato path(?Start,?Goal,?Path) = Path `e una lista che
rappresenta un cammino da Start a Goal nel grafo definito nel programma.
Suggerimento: utilizzare un predicato ausiliario a quattro argomenti
path(?Start,?Goal,?Path,+Visited) = Path `e una lista che rappresenta un cammino da Start a Goal che non passa per nessuno dei nodi
della lista Visited. */
path(Start, Goal, Path) :- path(Start, Goal, Path, []).
path(Goal, Goal, [Goal], Visited) :- not(member(Goal, Visited)).
path(Start, Goal, [Start|Path], Visited) :- not(member(Start, Visited)), arc(Start, N), path(N, Goal, Path, [Start|Visited]).


/* 17. (TODO) Rappresentiamo le formule della logica proposizionale classica mediante
strutture costruite mediante gli operatori definiti come segue:
:- op(600,yfx,&). % Congiunzione
:- op(650,yfx,v). % Disgiunzione
:- op(670,yfx,=>). % Implicazione
:- op(680,yfx,<=>). % Doppia implicazione
La negazione `e rappresentata dall’operatore - (unario), che ha precedenza
200 e tipo fy.
(a) Definire un predicato a due argomenti nnf(+X,-Y) che, data una
formula X, costruisca in Y la sua forma normale negativa.
(b) Rappresentiamo un’interpretazione mediante una lista di atomi: tutti
e solo quelli veri nell’interpretazione. Definire un predicato holds(+F,+L),
che determini se la formula F `e vera nell’interpretazione rappresentata
da L. */

