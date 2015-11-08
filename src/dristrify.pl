:- include('interface.pl').
:- include('utils.pl').
:- include('rules.pl').
:- include('delete.pl').

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

:- dynamic state/2.

distrify:-
	repeat,
	mainMenu,
	write('Option: '),
	getInt(R),
	R >= 1,
	R =< 4,
	menuOption(R, Pred),
	Pred.

menuOption(1, playerVsPlayer).
menuOption(2, playerVsPlayer).
menuOption(3, playerVsPlayer).
menuOption(4, playerVsPlayer).

playerVsPlayer:-emptyBoard(T),
	player1(P),
	assert(state(T,P)),
	printBoard(T),
	mainPvP.

mainPvP:-
	repeat,
	retract(state(T1, P1)),
	playPvP(T1, P1, T2, P2),
	assert(state(T2, P2)),
	done(T1,P1),
	mensagem(P1).

playPvP(B1, P1, B2, P2):- playerToString(P1, String),
	write(String),
	write(' turn'),
	nl,
	getNewPieceInfo(C,R),
	getPiece(R, C, B1, Piece),
	Piece == emptyCell,
	validFirstMove(R,C,B1,P1, Triplet),
	setPiece(R, C, P1, B1, B2),
	printBoard(B2),
	( Triplet == 0 -> getNewPieceInfo(C2,R2),
	getPiece(R2, C2, B2, Piece2),
	Piece2 == emptyCell,
	validSecondMove(R2,C2,B2,P1),
	setPiece(R2, C2, P1, B2, B3),
	printBoard(B3); write('When you creat a triplet you only have one move!'), nl),
	( P1 == black -> P2 = white;
	P2 = black),
	!.


done(Board, Player):- startPath(0,0,Board,Player).

mensagem(P1):- playerToString(P1, S), write(S), write(' wins!'), nl.
