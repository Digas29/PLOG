:- include('interface.pl').
:- include('utils.pl').
:- include('rules.pl').

emptyBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).

intermediumBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, white, emptyCell],
	[emptyCell, emptyCell, white, emptyCell, white, white, emptyCell, black, white],
	[emptyCell, emptyCell, emptyCell, black, emptyCell, black, white, emptyCell, black],
	[emptyCell, white, black, emptyCell, white, black, emptyCell, black, emptyCell],
	[emptyCell, emptyCell, black, white, black, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, white, emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, white, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, white, black, white, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).

finalBoard([
	[emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell, black, white, emptyCell],
	[emptyCell, emptyCell, white, black, white, white, emptyCell, black, white],
	[emptyCell, white, emptyCell, black, white, black, white, emptyCell, black],
	[emptyCell, white, black, emptyCell, white, black, white, black, emptyCell],
	[emptyCell, emptyCell, black, white, black, emptyCell, emptyCell, white, black],
	[emptyCell, white, black, emptyCell, white, black, emptyCell, black, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, white, black, emptyCell, black, emptyCell],
	[emptyCell, white, white, white, emptyCell, white, black, white, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell]]).


:- dynamic state/2.

distrify:-
emptyBoard(T),
player1(P),
assert(state(T,P)),
printBoard(T),
main.

main:-
	repeat,
	retract(state(T1, P1)),
	play(T1, P1, T2, P2),
	assert(state(T2, P2)),
	done(T1,P1),
	mensagem.

play(B1, P1, B2, P2):- playerToString(P1, String),
	write(String),
	write(' turn'),
	nl,
	getNewPieceInfo(C,R),
	getPiece(R, C, B1, Piece),
	Piece == emptyCell,
	validFirstMove(R,C,B1,P1, Triplet),
	setPiece(R, C, P1, B1, B2),
	printBoard(B2),
	( Triplet == 0 -> getNewPieceInfo(C2,R2),
	getPiece(R2, C2, B2, Piece2),
	Piece2 == emptyCell,
	validSecondMove(R2,C2,B2,P1),
	setPiece(R2, C2, P1, B2, B3),
	printBoard(B3); write('When you creat a triplet you only have one move!'), nl),
	( P1 == black -> P2 = white;
	P2 = black),
	!.

getNewPieceInfo(Column, Row):-
	repeat,
	write('Column:'),
	getChar(Char),
	columnToInt(Char, Column),
	write('Row:'),
	getInt(R),
	R =< 9,
	R >= 1,
	Row is R - 1.

done(Board, Player):- startPath(0,0,Board,Player).

mensagem:- write('fim!'), nl.
