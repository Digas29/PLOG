:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).
adjacentP(R, C, R1, C1, Board, Player, Path):-
  R1 is R + 1,
  C1 is C + 1,
  R1 =< 8,
  C1 =< 8,
  once(getPiece(R1,C1, Board, Piece)),
  Piece == Player,
  \+ member([R1,C1], Path).

adjacentP(R, C, R, C1, Board,Player, Path):-
  C1 is C + 1,
  C1 =< 8,
  once(getPiece(R,C1, Board, Piece)),
  Piece == Player,
  \+ member([R,C1], Path).

adjacentP(R, C, R1, C1, Board,Player, Path):-
  R1 is R - 1,
  C1 is C + 1,
  R1 >= 0,
  C1 =< 8,
  once(getPiece(R1,C1, Board, Piece)),
  Piece == Player,
  \+ member([R1,C1], Path).

adjacentP(R, C, R1, C, Board, Player, Path):-
  R1 is R - 1,
  R1 >= 0,
  once(getPiece(R1,C, Board, Piece)),
  Piece == Player,
  \+ member([R1,C], Path).

adjacentP(R, C, R1, C1, Board, Player, Path):-
  R1 is R - 1,
  C1 is C - 1,
  R1 >= 0,
  C1 >= 0,
  once(getPiece(R1,C1, Board, Piece)),
  Piece == Player,
  \+ member([R1,C1], Path).

adjacentP(R, C, R, C1, Board, Player, Path):-
  C1 is C - 1,
  C1 >= 0,
  once(getPiece(R,C1, Board, Piece)),
  Piece == Player,
  \+ member([R,C1], Path).

adjacentP(R, C, R1, C1,Board,Player, Path):-
  R1 is R + 1,
  C1 is C - 1,
  R1 =< 8,
  C1 >= 0,
  once(getPiece(R1,C1, Board, Piece)),
  Piece == Player,
  \+ member([R1,C1], Path).

adjacentP(R, C, R1, C,Board,Player, Path):-
  R1 is R + 1,
  R1 =< 8,
  once(getPiece(R1,C, Board, Piece)),
  Piece == Player,
  \+ member([R1,C], Path).

pathAux2(_,_,_, _, [], _, []).
pathAux2(R,C,Board, Player, [[R,C] | PathTail], PathSoFar, _):-
	adjacentP(R,C, R1, C1, Board, Player, PathSoFar),
  findall([R2,C2], adjacentP(R1,C1, R2, C2, Board, Player, PathSoFar), Adj1),
  pathAux2(R1, C1, Board, Player, PathTail, [[R1,C1] | PathSoFar], Adj1).

path2(R,C,Board, Player, Path):-
  findall([R2,C2], adjacentP(R,C, R2, C2, Board, Player, []), Adj),
  pathAux2(R,C,Board, Player, Path, [[R,C]| []], Adj).

checkDone(Path,black,Points):-
  member([0,_], Path),
  member([8,_], Path),
  Points = 10000.

checkDone(Path,white,Points):-
  member([_,0], Path),
  member([_,8], Path),
  Points = 10000.

pathLength([], [], _).
pathLength([Head|Tail], [L | Tail1], Player):-
  length(Head, L),
  pathLength(Tail, Tail1, Player).

checkIfAnyDone([], _, _).
checkIfAnyDone([Head | Tail], Player, Points):-
  checkDone(Head, Player, Points);
  checkIfAnyDone(Tail, Player, Points).

evaluate(R, C, Board, Player, Points):-
  findall(Path, path2(R,C,Board, Player, Path), Paths),
  pathLength(Paths, Lengths, Player),
  maximum_at(Lengths, Points, Index),
  nth0(Index,Paths,Path),
  checkIfAnyDone(Paths, Player, Points).

evaluateMoves([], _, _, []).
evaluateMoves([[R,C] | Tail], Board, Player, [Points | Tail1]):-
  evaluate(R, C, Board, Player, Points),
  evaluateMoves(Tail, Board, Player, Tail1).

maximum_at(L,Max,Pos) :-
   maplist(#>=(Max),L),
   nth0(Pos,L,Max).
teste1:- intermediumBoard(T), findall(Path, path(5,3,T, black, Path), Paths), write(Paths).
teste:- intermediumBoard(T),validSecondMoves(T, black, ListOfMoves), write(ListOfMoves), nl,
evaluateMoves(ListOfMoves,T,black,P), write(P).
