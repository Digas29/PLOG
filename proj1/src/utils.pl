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
	setPieceList(I1, Elem, L, ResL), !.

getPiece(0, Col, [Head |_], Piece):- getPieceList(Col, Head, Piece).
getPiece(Row, Col, [_| Tails], Piece):-
	Row > 0,
	Row1 is Row - 1,
	getPiece(Row1, Col, Tails, Piece), !.

getPieceList(0, [Head |_], Head):- !.
getPieceList(Col, [_| Tails], Piece):-
	Col > 0,
	Col1 is Col - 1,
	getPieceList(Col1, Tails, Piece).

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

nextCell(R, C, R1, C1):-
	Col is C + 1,
	(Col > 8 -> R1 is R+1, C1 is 0;
	R1 is R, C1 is Col).
validFirstMovesAux(9,C,1,_,_, [[8,C] | []]).
validFirstMovesAux(9,_,0,_,_, []).
validFirstMovesAux(R,C,1,Board, Player, [[R,C] | ListOfMoves]):-
	nextCell(R, C, Row, Col),
	(validFirstMove(Row,Col,Board, Player, _), getPiece(Row,Col, Board, Piece), Piece == emptyCell -> validFirstMovesAux(Row,Col,1,Board, Player, ListOfMoves);
	validFirstMovesAux(Row,Col,0,Board, Player, ListOfMoves)).

validFirstMovesAux(R,C,0,Board, Player, ListOfMoves):-
	nextCell(R, C, Row, Col),
	(validFirstMove(Row,Col,Board, Player, _), getPiece(Row,Col, Board, Piece), Piece == emptyCell -> validFirstMovesAux(Row,Col,1,Board, Player, ListOfMoves);
	validFirstMovesAux(Row,Col,0,Board,Player, ListOfMoves)).

validFirstMoves(Board, Player, ListOfMoves):-
	(validFirstMove(0,0,Board, Player, _), getPiece(0,0, Board, Piece), Piece == emptyCell -> validFirstMovesAux(0,0,1,Board, Player, ListOfMoves);
	validFirstMovesAux(0,0,0,Board, Player, ListOfMoves)).

validSecondMovesAux(9,C,1,_,_, [[8,C] | []]).
validSecondMovesAux(9,_,0,_,_, []).
validSecondMovesAux(R,C,1,Board, Player, [[R,C] | ListOfMoves]):-
	nextCell(R, C, Row, Col),
	(validSecondMove(Row,Col,Board, Player), getPiece(Row,Col, Board, Piece), Piece == emptyCell -> validSecondMovesAux(Row,Col,1,Board, Player, ListOfMoves);
	validSecondMovesAux(Row,Col,0,Board, Player, ListOfMoves)).

validSecondMovesAux(R,C,0,Board, Player, ListOfMoves):-
	nextCell(R, C, Row, Col),
	(validSecondMove(Row,Col,Board, Player), getPiece(Row,Col, Board, Piece), Piece == emptyCell -> validSecondMovesAux(Row,Col,1,Board, Player, ListOfMoves);
	validSecondMovesAux(Row,Col,0,Board,Player, ListOfMoves)).

validSecondMoves(Board, Player, ListOfMoves):-
	(validFirstMove(0,0,Board, Player, _), getPiece(0,0, Board, Piece), Piece == emptyCell -> validSecondMovesAux(0,0,1,Board, Player, ListOfMoves);
	validSecondMovesAux(0,0,0,Board, Player, ListOfMoves)).

getMove(0, [Head|_], Head).
getMove(Index, [_|Tail], Move):-
	Index1 is Index - 1,
	getMove(Index1, Tail, Move).

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
