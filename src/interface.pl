rowIdentifiers([' 1 ',' 2 ', ' 3 ',' 4 ',' 5 ',' 6 ',' 7 ',' 8 ', ' 9 ']).

getSymbol(emptyCell, ' ').
getSymbol(white, 'O').
getSymbol(black, '#').


printColumnId :- write('      A     B     C     D     E     F     G     H     I'),nl.
printInitialSeparator :- write('    _____________________________________________________ '),nl.
printMiddleSeparator :- write('   |     |     |     |     |     |     |     |     |     |'),nl.
printFinalSeparator :-  write('   |_____|_____|_____|_____|_____|_____|_____|_____|_____|'),nl.

printCell(Char) :- write('|  '), write(Char), write('  ').
printBoardLine([]) :- write('|'), nl, printFinalSeparator.
printBoardLine([Head|Tail]) :- getSymbol(Head,Char), printCell(Char), printBoardLine(Tail).

printBoardAux([],[]) :- nl.
printBoardAux([Head|Tail], [RowId|RowTail]) :- printMiddleSeparator, write(RowId), printBoardLine(Head), printBoardAux(Tail, RowTail).

printBoard(Board) :- write('\33\[2J'), printColumnId, printInitialSeparator, rowIdentifiers(RowId), printBoardAux(Board, RowId).


getChar(Input):-
	get_char(Input),
	get_char(_).

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48,
	get_code(_).
