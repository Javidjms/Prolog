a:- b,!,c.
a:-j.
b:-f.
b:-g.
c:-d.
c:-e.
d:-fail.
e:-fail.
f.
g.
j:-h.
j:-i.

not(P):- P,!,fail.
not(P).

conc([],L,L).
conc([X|Q],L,[X|Q1]):-conc(Q,L,Q1).


inverse([],L,L).
inverse([X|Q],L,R):-inverse(Q,[X|L],R).


ajoutFin(X,[],[X]).
ajoutFin(X,[Y|Q],[Y|R]):-ajoutFin(X,Q,R).

etatInitial(0).
etatInitial(2).
etatFinal(1).
etatFinal(4).
transition(0,1,a).
transition(1,0,b).
transition(2,3,a).
transition(3,2,b).
transition(3,4,a).
valider(Mot):-etatInitial(E1),validerTransition(E1,E2,Mot,EF),etatFinal(EF),!.
validerTransition(EF,E2,[],EF).
validerTransition(E1,E2,[X|Q],EF):-transition(E1,E2,X),validerTransition(E2,E3,Q,EF).

adjacent(X,Y,[Lp,[[X,Y]|La]]).
adjacent(X,Y,[Lp,[[Y,X]|La]]).
adjacent(X,Y,[Lp,[[X1,Y2]|La]]):-adjacent(X,Y,[Lp,La]).

membre(X,[X|L]).
membre(X,[Y|L]):-membre(X,L).

chemin(D,A,G,[A]):-adjacent(D,A,G).
chemin(D,A,G,[X|L]):-adjacent(D,X,G),chemin(X,A,G,L),not(membre(X,L)).