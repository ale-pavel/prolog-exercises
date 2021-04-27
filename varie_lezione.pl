/* branch(+T,?Leaf,?Ramo) = Ramo è un ramo di T che parte dalla radice e va fino ad una foglia che ha etichetta Leaf */

branch(t(X,empty,empty), X, [X]).
branch(t(Y,Left,Right), X, [Y|Ramo]) :- branch(Left, X, Ramo); branch(Right, X, Ramo).  


genitore(angelo,annarita).
genitore(angelo,andrea).

/* Se mettessi il not prima dei due genitore avrei sempre false, poiché chiamando fratello(andrea, Z) quando si cerca di unificare not(X=Y) avrei X=andrea e Y non vincolata. 
Per come funziona = se ho una variabile non vincolata fallisco. Il not non è quello della logica, bensì mi dice che non posso dimostrare qualcosa col programma (non che non è vero). 
Il not dovrebbe essere invocato quando tutte le variabili sono istanziate (cioé dopo le clausole genitore). */

fratello(X,Y) :- genitore(Z,X), genitore(Z,Y), not(X=Y).

/* Il not in Prolog ha qualcosa in più rispetto alla logica, altrmenti non basterebbe la risoluzione SLD per le ultime due clausole intersect. 
Provando a scriverle in forma prenessa ci si accorge che quella con not(member(..)) non è Horn */
intersect(_, [], []).
intersect([], _, []).
intersect([X|Rest], Set, [X|Result]) :- member(X, Set), intersect(Rest, Set, Result).
intersect([X|Rest], Set, Result) :- not(member(X, Set)), intersect(Rest, Set, Result).


max(X,Y,X) :- X >= Y, !.
max(X,Y,Y) :- X < Y.


merge(X, [], X).
merge([], X, X).
merge([X|Rest1], [Y|Rest2], [X,Y|Result]) :- X=Y, !, merge(Rest1, Rest2, Result).
merge([X|Rest1], [Y|Rest2], [X|Result]) :- X<Y, !, merge(Rest1, [Y|Rest2], Result).
merge([X|Rest1], [Y|Rest2], [X|Result]) :- X>Y, merge([X|Rest1], Rest2, Result). %%X>Y inutile in realtà, è l'opzione che per forza avviene dopo gli altri controlli


intersect(_, [], []).
intersect([], _, []).
intersect([X|R1], L2, [X|Result]) :- member(X, L2), !, intersect(R1, L2, Result).
intersect([_|R1], L2, Result) :- intersect(R1, L2, Result).

%%in alternativa

intersect2(_, [], []).
intersect2([], _, []).
intersect2([X|R1], L2, [X|Result]) :- member(X, L2), intersect2(R1, L2, Result).
intersect2([_|R1], L2, Result) :- not(member(X,L2), intersect2(R1, L2, Result).


%% concat(+L1, +L2, ?Result)
concat([], L2, L2) :- !.
concat([X|L1], L2, [X|Result]) :- concat(L1, L2, Result).





