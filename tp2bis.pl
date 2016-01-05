conc([],L,L).
conc([X|Q],L,[X|Q1]):-conc(Q,L,Q1).

memefeuilles(X,Y):-liste(X,Lx),liste(Y,Ly),comparerliste(Lx,Ly).

liste([X|L],Lx,S):-liste(X,Lx1,S1),!,liste(L,Lx2,S2).
liste([],S,S).
liste(X,[X|Lx],S).
comparerliste([X|Lx],[X|Ly]):-comparerliste(Lx,Ly).