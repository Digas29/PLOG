:- include('interface.pl').
:- include('menus.pl').
:- include('lists.pl').
:- include('restrictions.pl').
:- include('dots.pl').

option(1, size).

kropki:-
  mainMenu,
  write('Option: '),
  getInt(Option),
  option(Option, Pred),
  Pred.

size:-
  sizeMenu,
  write('Size: '),
  getInt(Size),
  play(Size).

play(Size):-
  retractall(hor(_,_,_)),
	retractall(ver(_,_,_)),
  newBoard(Size,Board),
  generateBoard(Board, New),
  createDots(New, 1, 1, Size),
  newBoard(Size,SolBoard),
  printBoard(SolBoard),
  solveBoard(SolBoard, Solved),
  printBoard(Solved).
