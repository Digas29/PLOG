setPiece(0, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [NewRowAtTheHead|RemainingRows]):-
	setPieceList(ElemCol, NewElem, RowAtTheHead, NewRowAtTheHead).

setPiece(ElemRow, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [RowAtTheHead|ResultRemainingRows]):-
	ElemRow > 0,
	ElemRow1 is ElemRow-1,
	setPiece(ElemRow1, ElemCol, NewElem, RemainingRows, ResultRemainingRows).

setPieceList(0, Elem, [_|L], [Elem|L]).
setPieceList(I, Elem, [H|L], [H|ResL]):-
	I > 0,
	I1 is I-1,
	setPieceList(I1, Elem, L, ResL).

getPiece(0, Col, [Head |_], Piece):- getPieceList(Col, Head, Piece).
getPiece(Row, Col, [_| Tails], Piece):-
	Row > 0,
	Row1 is Row - 1,
	getPiece(Row1, Col, Tails, Piece).

getPieceList(0, [Head |_], Head):- !.
getPieceList(Col, [_| Tails], Piece):-
	Col > 0,
	Col1 is Col - 1,
	getPieceList(Col1, Tails, Piece).

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
