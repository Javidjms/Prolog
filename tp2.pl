not(P):- P,!,fail.
not(P).

membre(X,[X|Q]).
membre(X,[Y|Q]):- membre(X,Q).

inclus([],X).
inclus([X|Q],Y):- membre(X,Y),inclus(Q,Y).

enlever(X,[X|Q],Q).
enlever(X,[Y|Q],[Y|Z]):-enlever(X,Q,Z).

egal-ens(X,X).
egal-ens(X,Y):-inclus(X,Y),inclus(Y,X).

intersection([],X,[]).
intersection([X1|X],Y,[X1|Z]):-membre(X1,Y),!,intersection(X,Y,Z).
intersection([X1|X],Y,Z):-intersection(X,Y,Z).

union([],X,X).
union([X1|X],Y,Z):-membre(X1,Y),!,union(X,Y,Z).
union([X1|X],Y,[X1|Z]):-union(X,Y,Z).

disjoint([],X).
disjoint([X|Q1],Y):- not(membre(X,Y)),disjoint(Q1,Y).

soustraction([],Y,Y).
soustraction([X|Q],Y,Z):-membre(X,Y),!,enlever(X,Y,Y1),soustraction(Q,Y1,Z).
soustraction([X|Q],Y,Z):-not(membre(X,Y)),soustraction(Q,Y,Z).

inserer(X,[],[X]).
inserer(X,[Y|Q],[Y|S]):-X>Y,!,inserer(X,Q,S).
inserer(X,[Y|Q],[X|[Y|Q]]):-X=<Y.

tri_ins([],[]).
tri_ins([X|L],S):-tri_ins(L,S1),inserer(X,S1,S).

permut([],[]).
permut(L,[X|S]):-enlever(X,L,S1),permut(S1,S).

tri_perm([],[]).
tri_perm(L,S):-permut(L,S1),est_triee(S1),!,S=S1.

est_triee([X]).
est_triee([X,Y|L]):- X=<Y,est_triee([Y|L]).

eclater(P,[],[],[]).
eclater(P,[X|L],[X|L1],L2):-P>X,!,eclater(P,L,L1,L2). 
eclater(P,[X|L],L1,[X|L2]):-P=<X,eclater(P,L,L1,L2). 

conc([],L,L).
conc(L,[],L).
conc([X|Q],L,[X|Q1]):-conc(Q,L,Q1).

tri1([],[]).
tri1([X|L],S):-eclater(X,L,L1,L2),conc(L1,[X|L2],S).

tri2([],A,A).
tri2([X|L],S1,S):-eclater(X,L,L1,L2),tri2(L2,A,L4),tri2(L1,[X|L4],S).

ajout(fin,A,[fin,A,fin]).
ajout([G,N,D],A,R):-A<N,!,ajout(G,A,G1),R=[G1,N,D].
ajout([G,N,D],A,R):-A>N,!,ajout(D,A,D1),R=[G,N,D1].

supprimer([fin,A,fin],A,fin).
supprimer([fin,A,D],A,D).
supprimer([G,A,fin],A,G).
supprimer([G,A,D],A,R):-leadermin(D,Nd),leadermax(G,Ng),max(Ng,Nd,S),A=S,supprimer([G,A,D],S,R2),R=R2.
supprimer([G,N,D],A,R):-A<N,!,supprimer(G,A,G1),R=[G1,N,D]. 
supprimer([G,N,D],A,R):-A>N,!,supprimer(D,A,D1),R=[G,N,D1]. 

leader([fin,A,fin],A).
leadermin([G,A,D],N):-leadermin(G,N).

leadermax([fin,A,fin],A).
leadermax([G,A,D],N):-leadermax(D,N).

