not(P):- P,!,fail.
not(P).

permut([],[]).
permut(L,[X|S]):-enlever(X,L,S1),permut(S1,S).

enlever(X,[X|Q],Q).
enlever(X,[Y|Q],[Y|Z]):-enlever(X,Q,Z).

conc([],L,L).
conc(L,[],L).
conc([X|Q],L,[X|Q1]):-conc(Q,L,Q1).



boite(L):- generer(L),tester(L).
generer(L):- permut([ver,serpent,lion,canard,chat,pingouin],L).
tester(L):- griffes(L),aCote(canard,chat,L),entre(ver,serpent,pingouin,L),entre(pingouin,ver,lion,L),!.

griffes(L):-L=[X1,X2,X3,X4,X5,X6],permut([lion,chat],[X2,X3]).
griffes(L):-L=[X1,X2,X3,X4,X5,X6],permut([chat,lion],[X2,X3]).

aCote(X,Y,[X|[Y|L]]).
aCote(Y,X,[X|[Y|L]]).
aCote(X,Y,[Z|L]):-aCote(X,Y,L).

entre(X,Y,Z,L):-aCote(X,Y,L),aCote(X,Z,L).   
entre(X,Y,Z,L):-aCote(X,Z,L),aCote(X,Y,L).

reines([],[],S,S).
reines([L|Ls],Cs,P,S):-enlever(C,Cs,Cs2),compatible([L,C],P),reines(Ls,Cs2,[[L,C]|P],S).

compatible(X,[]).
compatible([L,C],[[L1,C1]|Liste]):- L\=L1,C\=C1,not(diagonale([L,C],[L1,C1])),compatible([L,C],Liste).

diagonale([L1,C1],[L2,C2]):-abs(L1-L2,S1),abs(C1-C2,S2),S1==S2.

abs(X,S):-X>=0,!,S is X.
abs(X,S):-X<0,S is-X.

