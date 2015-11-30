:- use_module(library(lists)).


newBoard(Size, Board):- newBoardAux(Size, Size, Board).

newBoardAux(0,_,[]).
newBoardAux(Pos, Size, [Head | Tails]):-
  Pos > 0,
  length(Head, Size),
  Pos1 is Pos - 1,
	newBoardAux(Pos1, Size, Tails).
