crosscut(R, C, R1, C1, R, C1, R1, C):-
	R1 is R + 1,
	C1 is C + 1,
	R1 =< 8,
	C1 =< 8.

crosscut(R, C, R1, C1, R, C1, R1, C):-
	R1 is R + 1,
	C1 is C - 1,
	R1 =< 8,
	C1 >= 0.

crosscut(R, C, R1, C1, R, C1, R1, C):-
	R1 is R - 1,
	C1 is C - 1,
	R1 =< 8,
	C1 =< 8.

crosscut(R, C, R1, C1, R, C1, R1, C):-
	R1 is R - 1,
	C1 is C + 1,
	R1 >= 0,
	C1 =< 8.

adjacent(R, C, R1, C1):-
	R1 is R + 1,
	C1 is C + 1,
	R1 =< 8,
	C1 =< 8.

adjacent(R, C, R, C1):-
	C1 is C + 1,
	C1 =< 8.

adjacent(R, C, R1, C1):-
	R1 is R - 1,
	C1 is C + 1,
	R1 >= 0,
	C1 =< 8.

adjacent(R, C, R1, C):-
	R1 is R - 1,
	R1 >= 0.

adjacent(R, C, R1, C1):-
	R1 is R - 1,
	C1 is C - 1,
	R1 >= 0,
	C1 >= 0.

adjacent(R, C, R, C1):-
	C1 is C - 1,
	C1 >= 0.

adjacent(R, C, R1, C1):-
	R1 is R + 1,
	C1 is C - 1,
	R1 =< 8,
	C1 >= 0.

adjacent(R, C, R1, C):-
	R1 is R + 1,
	R1 =< 8.

path([[R,8] | _], Board, white):-
	getPiece(R,8, Board, Piece),
	Piece == white.
path([[8,C] | _], Board, black):-
	getPiece(8,C, Board, Piece),
	Piece == black.

path([[R,C] | T], Board, Player):-
	adjacent(R, C, R1, C1),
	once(getPiece(R1,C1, Board, Piece)),
	Piece == Player,
	\+ member([R1, C1], T),
	path([[R1, C1] | [[R,C] | T]], Board, Player).

startPath(9,_,_,black).
startPath(_,9,_,white).
startPath(R,C, Board, white):-
	R =< 8,
	C =< 8,
	getPiece(R,C, Board, Piece),
	(Piece \== white ->  R1 is R + 1, startPath(R1, C, Board, white);
	(\+ path([[R,C]], Board, white) -> R1 is R + 1, startPath(R1, C, Board, white))).

startPath(R,C, Board, black):-
	R =< 8,
	C =< 8,
	getPiece(R,C, Board, Piece),
	(Piece \== black ->  C1 is C + 1, startPath(R, C1, Board, black);
	(\+ path([[R,C]], Board, black) -> C1 is C + 1, startPath(R, C1, Board, black);
	true)).

checkCrosscut(R, C, Board, Player):-
	crosscut(R, C, R1, C1, R2, C2, R3, C3),
	getPiece(R1, C1, Board, Piece),
	Piece == Player,
	getPiece(R2, C2, Board, Piece2),
	Piece2 \== Player,
	getPiece(R3, C3, Board, Piece3),
	Piece3 \== Player.

triplet(R,C,Board,Player):-
  Rm2 is Row - 2,
  Rm2 >= 0,
  Rm1 is Row - 1,
  getPiece(Rm2, C, Board, Piece),
	Piece == Player,
	getPiece(Rm1, C, Board, Piece2),
	Piece2 == Player.
triplet(R,C,Board,Player):-
  Rm2 is Row - 2,
  Rm2 >= 0,
  Rm1 is Row - 1,
  getPiece(Rm2, C, Board, Piece),
	Piece == Player,
	getPiece(Rm1, C, Board, Piece2),
	Piece2 == Player.
checkTriplet(R, C, Board, Player):- nl.
