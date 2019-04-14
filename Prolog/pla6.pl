supp(s1,smith,20,london).
supp(s2,jones,10,paris).
supp(s3,blake,30,paris).
supp(s4,clark,20,london).
supp(s5,adams,30,athens).
part(p1, nut,   red,   12, london).
part(p2, bolt,  green, 17, paris).
part(p3, screw, blue,  17, oslo).
part(p4, screw, red,   14, london).
part(p5, cam,   blue,  12, paris).
part(p6, cog,   red,   19, london).
proj(j1, sorter,  paris).
proj(j2, display, rome).
proj(j3, ocr,     athens).
proj(j4, console, athens).
proj(j5, raid,    london).
proj(j6, eds,     oslo).
proj(j7, tape,    london).
sppj(s1, p1, j1, 200).
sppj(s1, p1, j4, 700).
sppj(s2, p2, j1, 400).
sppj(s2, p2, j2, 200).
sppj(s2, p2, j3, 200).
sppj(s2, p2, j4, 500).
sppj(s2, p2, j5, 600).
sppj(s2, p2, j6, 400).
sppj(s2, p2, j7, 800).
sppj(s2, p5, j2, 100).
sppj(s3, p2, j1, 200).
sppj(s3, p4, j2, 500).
sppj(s4, p6, j3, 300).
sppj(s4, p6, j7, 300).
sppj(s5, p2, j2, 200).
sppj(s5, p2, j4, 100).
sppj(s5, p5, j5, 500).
sppj(s5, p5, j7, 100).
sppj(s5, p6, j2, 200).
sppj(s5, p1, j4, 100).
sppj(s5, p2, j4, 200).
sppj(s5, p4, j4, 800).
sppj(s5, p5, j4, 400).
sppj(s5, p6, j4, 500).
suppliesparts(S,P,N,T,C,J,A):-supp(S,N,T,C),sppj(S,P,J,A).
usedbyproject(P,N,C,A,L,S,J,D):-part(P,N,C,A,L),sppj(S,P,J,D).
usesparts(J,A,B,P,N,S,J,X,G,H):-proj(J,A,B),sppj(S,P,J,X),part(P,N,G,H).
notinlocation(S,N,T,C,J,A,B):-supp(S,N,T,C),proj(J,A,B), not(C=B).

% This function takes two projects as arguements and a varaible to instantiate.
% It instantiates a list containing the supplier information.
findsuppliers(Proj1,Proj2,[S,N,T,C]):-
    proj(Projnum1,Proj1,_),
    proj(Projnum2,Proj2,_),
    suppliesparts(S,_,N,T,C,Projnum1,_),
    suppliesparts(S,_,N,T,C,Projnum2,_).
    