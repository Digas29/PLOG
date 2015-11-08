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
