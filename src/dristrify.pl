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

printBoard(Board) :- printColumnId, printInitialSeparator, rowIdentifiers(RowId), printBoardAux(Board, RowId).

