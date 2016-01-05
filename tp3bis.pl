not(P):- P,!,fail.
not(P).

permut([],[]).
permut(L,[X|S]):-enlever(X,L,S1),permut(S1,S).

enlever(X,[X|Q],Q).
enlever(X,[Y|Q],[Y|Z]):-enlever(X,Q,Z).


mastermind(L,H):-generer(L),tester(L,H).
generer(L):-permut([bleu,blanc,jaune,vert,rouge],L).
tester(L,H):-compatiblehistorique(L,H),interaction(L,S),ajouthistorique(L,S,H,Hnew),evaluation(L,Hnew,S).
evaluation(L,H,S):-S==5.
evaluation(L,H,S):-S\==5,write(H),mastermind(L,H).

compatiblehistorique(L,[]).
compatiblehistorique(L,[[V1,L1]|H]):-occurence(L,L1,VT),VT>=V1,!.
compatiblehistorique(L,H):-occurence(L,L1,VT),VT\==V1,compatiblehistorique(L,H).

ajouthistorique(L,S,H,[[S,L]|H]).

interaction(L,S):-write(L),write('Donner le nombre de couleurs correctes :  '),read(S).

occurence([],[],0).
occurence([X|L],[X|L1],S):- occurence(L,L1,S1),!,S is S1+1.
occurence([X|L],[Y|L1],S):- occurence(L,L1,S).

voyage(1,0).
voyage(1,1).
voyagePossible(Etat,[X,Y]):-voyage(X,Y).