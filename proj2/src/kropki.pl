:- include('interface.pl').
:- include('menus.pl').
:- include('lists.pl').
:- include('restrictions.pl').
:- include('dots.pl').


kropki:-
  mainMenu,
  write('Size: '),
  getInt(Size),
  play(Size).

play(Size):-
  retractall(hor(_,_,_)),
	retractall(ver(_,_,_)),
  retractall(time(_)),
  newBoard(Size,Board),
  generateBoard(Board, New),
  createDots(New, 1, 1, Size),
  newBoard(Size,SolBoard),
	write('\33\[2J'),
  printBoard(SolBoard),
  solveBoard(SolBoard, Solved),
  printBoard(Solved),
  fd_statistics,
  time(T),
  format('~n It took ~3d sec to solve this board.~n', T).
