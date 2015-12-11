getChar(Input):-
	get_char(Input),
	get_char(_), !.

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48,
	get_code(_),
	 !.

waitForEnter:-
	get_char(_).

printSeparator(1, 1):-
	write(' ___ ').
printSeparator(Size, Size):-
	write('____').
printSeparator(1, Size):-
	write(' ___'),
	printSeparator(2, Size).
printSeparator(Index, Size):-
	write('____'),
	Index1 is Index + 1,
	printSeparator(Index1, Size).

printLimits(1,1):-
	write('|   |').
printLimits(1,Size):-
	write('|   |'),
	printLimits(2,Size).
printLimits(Size,Size):-
	write('   |').
printLimits(Index,Size):-
	write('   |'),
	Index1 is Index + 1,
	printLimits(Index1,Size).

printInitialSeparator(Size):- printSeparator(1,Size).

printElem(Elem):-
	number(Elem),
	write(Elem).

printElem(_):-
	write(' ').

dotR(Row,Col):-
	hor(Row,Col,Color),
	if(Color == black, write('*'), write('o')).

dotR(_,_):-
	write('|').

dotC(Row,Col):-
	ver(Row,Col,Color),
	if(Color == black, write('*'), write('o')).

dotC(_,_):-
	write('_').

printRow([],_,_).
printRow([Elem|Rest],Row,Col):-
	write(' '),
	printElem(Elem),
	write(' '),
	dotR(Row,Col),
	Col1 is Col + 1,
	printRow(Rest, Row, Col1).

printDownLimits(Row, Size, Size):-
	write('_'),
	dotC(Row, Size),
	write('_|').
printDownLimits(Row, Col, Size):-
	write('_'),
	dotC(Row, Col),
	write('_|'),
	Col1 is Col + 1,
	printDownLimits(Row,Col1, Size).

printBoardAux([], _, _).
printBoardAux([Row|Tails], R, Size):-
	printLimits(1,Size),nl,
	write('|'),
	printRow(Row, R, 1),
	nl,
	write('|'),
	printDownLimits(R, 1, Size),
	nl,
	R1 is R+1,
	printBoardAux(Tails, R1,Size).


printBoard(Board):-
	length(Board, Size),
	printInitialSeparator(Size),nl,
	printBoardAux(Board,1,Size).
