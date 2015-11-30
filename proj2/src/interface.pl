getChar(Input):-
	get_char(Input),
	get_char(_), !.

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48,
	get_code(_), !.

waitForEnter:-
	get_char(_).
