:- include('interface.pl').
:- include('menus.pl').
:- include('lists.pl').

option(1, play).
option(2, tutorial).

kropki:-
  mainMenu,
  write('Option: '),
  getInt(Option),
  option(Option, Pred),
  Pred.

play:-
  newBoard(9,Board),
  write(Board).
