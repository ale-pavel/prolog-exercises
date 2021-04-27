/* 3. Definire un predicato Prolog disordinati(+L,?D) che ha successo se e
solo se L è una lista di interi e D è una lista che contiene gli elementi
di L che sono minori dell’elemento precedente. Gli elementi di D devono
occorrere nello stesso ordine in cui occorrono in L. Ovviamente, se L è
   ordinata, D sarà vuota. */

/*Ad esempio, disordinati([1,10,5,6,7,4,9],Result) avrà successo con
Result = [5,4]. E disordinati([1,2,3,4,5,6],Result) avrà succes-
so con Result = [] (se la lista L è ordinata, D è vuota).*/
lista([1,10,5,6,7,4,9]).
lista2([1,2,3,4,5,6]).

disordinati([], []).
disordinati([_], []).
%Invece di X<Y correzione con X<=Y, poiché se X=Y l'elemento Y non andrà inserito in D
disordinati([X,Y|Rest], Result) :- X<=Y, !, disordinati([Y|Rest], Result).
disordinati([_,Y|Rest], [Y|Result]) :- disordinati([Y|Rest], Result).


