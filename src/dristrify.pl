:- include('interface.pl').
:- include('utils.pl').

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

player1(black).
player2(white).

playerToString(black, 'black').
playerToString(white, 'white').

columnToInt('A', 0).
columnToInt('B', 1).
columnToInt('C', 2).
columnToInt('D', 3).
columnToInt('E', 4).
columnToInt('F', 5).
columnToInt('G', 6).
columnToInt('H', 7).
columnToInt('I', 8).

columnToInt('a', 0).
columnToInt('b', 1).
columnToInt('c', 2).
columnToInt('d', 3).
columnToInt('e', 4).
columnToInt('f', 5).
columnToInt('h', 6).
columnToInt('h', 7).
columnToInt('i', 8).

:- dynamic state/2.

distrify:-
intermediateBoard(T),
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
	setPiece(R, C, P1, B1, B2),
	( P1 == black -> P2 = white;
	P2 = black),
	printBoard(B2),
	!.

getNewPieceInfo(Column, Row):-
	write('Column:'),
	getChar(Char),
	columnToInt(Char, Column),
	write('Row:'),
	getInt(R),
	Row is R - 1.

done(Board, Player):- startPath(0,0,Board,Player).
mensagem:- write('fim!'), nl.
