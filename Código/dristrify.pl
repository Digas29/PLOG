Board([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).

IntermediumBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, white, emptyCell],
	[emptyCell, emptyCell, white, emptyCell, white, white, emptyCell, black, white],
	[emptyCell, emptyCell, emptyCell, black, emptyCell, black, white, emptyCell, black],
	[emptyCell, white, black, emptyCell, white, black, emptyCell, black, emptyCell],
	[emptyCell, emptyCell, black, white, black, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, white, emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, white, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, white, black, white, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).

FinalBoard([
	[emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell, black, white, emptyCell],
	[emptyCell, emptyCell, white, black, white, white, emptyCell, black, white],
	[emptyCell, white, emptyCell, black, white, black, white, emptyCell, black],
	[emptyCell, white, black, emptyCell, white, black, white, black, emptyCell],
	[emptyCell, emptyCell, black, white, black, emptyCell, emptyCell, white, black],
	[emptyCell, white, black, emptyCell, white, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, white, black, emptyCell, emptyCell, emptyCell],
	[emptyCell, white, white, white, emptyCell, white, black, white, emptyCell],
	[emptyCell, emptyCell, black, emptyCell, emptyCell, emptyCell, black, emptyCell, emptyCell]]).


convertToChar(Cell, Char) :- (Cell =:= emptyCell -> Char = ' '; 
	Cell =:= black -> Char = 'O'; 
	Char  = 'X').

printBoardLine([Head|Tail]) :- (Head =/= 0 -> convertToChar(Head,Char), write(char), printBoardLine(Tail)).
printBoard([Head|Tail]) :- (Head =/= 0 -> printBoardLine(Head), printBoard(Tail)).
