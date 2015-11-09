:- include('interface.pl').
:- include('utils.pl').
:- include('rules.pl').
:- include('delete.pl').
:- include('evaluate.pl').
:- include('bot.pl').

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
menuOption(2, playerVsBot).
menuOption(3, botVsBot).

playerVsPlayer:-
	intermediumBoard(T),
	player1(P),
	assert(state(T,P)),
	printBoard(T),
	mainPvP.

playerVsBot:-
	emptyBoard(T),
	player1(P),
	assert(state(T,P)),
	botDifficulty,
	write('Option: '),
	getInt(R),
	R >= 1,
	R =< 2,
	printBoard(T),
	mainPvB(R).

botVsBot:-
	intermediumBoard(T),
	player1(P),
	assert(state(T,P)),
	botDifficulty,
	write('Option: '),
	getInt(R),
	R >= 1,
	R =< 2,
	printBoard(T),
	mainBvB(R).

mainPvP:-
	repeat,
	retract(state(T1, P1)),
	playP(T1, P1, T2, P2),
	assert(state(T2, P2)),
	done(T2,P1),
	mensagem(P1).

mainPvB(Dif):-
	repeat,
	retract(state(T1, P1)),
	playPvB(T1, P1, T2, P2, Dif),
	assert(state(T2, P2)),
	done(T2,P1),
	mensagem(P1).

mainBvB(Dif):-
	repeat,
	retract(state(T1, P1)),
	playBvB(T1, P1, T2, P2, Dif),
	assert(state(T2, P2)),
	done(T2,P1),
	mensagem(P1).

playP(B1, P1, B3, P2):- playerToString(P1, String),
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
	printBoard(B3); B3 = B2, write('When you create a triplet you only have one move!'), nl),
	( P1 == black -> P2 = white;
	P2 = black),
	!.

playPvB(B1, P1, B3, P2, Dif):-
	P1 == black,
	playP(B1, P1, B3, P2),
	( P1 == black -> P2 = white;
	P2 = black), !;
	bot(Dif, P1, B1, R, C, 1),
	validFirstMove(R,C, B1, P1, Triplet),
	setPiece(R, C, P1, B1, B2),
	printBoard(B2),
	columnToInt(S1, C),
	R10 is R + 1,
	write('Coords: '), write(S1), write(R10), nl,
	waitForEnter,
	( Triplet == 0 -> bot(Dif, P1, B2, R2, C2, 2),
	setPiece(R2, C2, P1, B2, B3),
	printBoard(B3),
	columnToInt(S2, C2),
	R11 is R2 + 1,
	write('Coords: '), write(S2), write(R11), nl, waitForEnter;
	B3 = B2, write('When you create a triplet you only have one move!'), nl),
	( P1 == black -> P2 = white;
	P2 = black),
	!.

playBvB(B1, P1, B3, P2, Dif):-
	bot(Dif, P1, B1, R, C,1),
	validFirstMove(R,C, B1, P1, Triplet),
	setPiece(R, C, P1, B1, B2),
	printBoard(B2),
	columnToInt(S1, C),
	R10 is R + 1,
	write('Coords: '), write(S1), write(R10), nl,
	waitForEnter,
	(Triplet == 0 -> bot(Dif, P1, B2, R2, C2, 2),
	setPiece(R2, C2, P1, B2, B3),
	printBoard(B3),
	columnToInt(S2, C2),
	R11 is R2 + 1,
	write('Coords: '), write(S2), write(R11), nl, waitForEnter;
	B3 = B2, write('When you create a triplet you only have one move!'), nl),
	( P1 == black -> P2 = white;
	P2 = black),
	!.

done(Board, Player):- startPath(0,0,Board,Player).

mensagem(P1):- playerToString(P1, S), write(S), write(' wins!'), nl.
