:- include("interface.pl").
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

:- dynamic state(Board, InitialPlayer).

distrify:- 
InitialBoard(T),
player1(P),
assert(state(T,P)),
printBoard(T),
main.

main:-
	repeat,
	retract(state(T1, P1)),
	play(T1, P1, T2, P2),
	assert(state(T2, P2)).

play(B1, P1, B2, P2):- playerToString(P1, String),
	write(string),
	write(' turn'),
	nl,
	write('Column:'),
	getChar(Char),
	columnToInt(Char, C),
	write('Row:'),
	getInt(R),
	setPiece(R, C, P1, B1, B2),
	( P1 == black -> P2 = white;
	P2 = black),
	printBoard(B2),
	!.

setPiece(0, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [NewRowAtTheHead|RemainingRows]):-
	setPieceList(ElemCol, NewElem, RowAtTheHead, NewRowAtTheHead).
setPiece(ElemRow, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [RowAtTheHead|ResultRemainingRows]):-
	ElemRow > 0,
	ElemRow1 is ElemRow-1,
	setMatrixElemAtWith(ElemRow1, ElemCol, NewElem, RemainingRows, ResultRemainingRows).
	
setPieceList(0, Elem, [_|L], [Elem|L]).
setPieceList(I, Elem, [H|L], [H|ResL]):-
	I > 0,
	I1 is I-1,
	setListElemAtWith(I1, Elem, L, ResL).






