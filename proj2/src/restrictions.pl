:- use_module(library(clpfd)).
:- use_module(library(random)).

setDomains([], _).
setDomains([H|T], Size):-
  domain(H, 1, Size),
  setDomains(T, Size).

rowRestrictions([]).
rowRestrictions([H|T]):-
  all_different(H),
  rowRestrictions(T).



randomVar(Vars,Var,Remaining) :-
  random_select(Var,Vars,Remaining),
	var(Var).

label([]).
label([H|T]):-
  labeling([variable(randomVar)], H),
  label(T).

generateBoard(Board,NewBoard):-
  length(Board, Size),
  setDomains(Board, Size),
  rowRestrictions(Board),
  transpose(Board, NewBoard1),
  rowRestrictions(NewBoard1),
  transpose(NewBoard1, NewBoard),
  label(NewBoard).

getCell(Board, Row, Col, Cell):-
  nth1(Row, Board, Elem),
  nth1(Col, Elem, Cell).

double(Elem, Elem2):-
  Elem #= Elem2 * 2 #\/ Elem2 #= Elem * 2.

consecutive(Elem, Elem2):-
  Elem #= Elem2 + 1 #\/ Elem2 #= Elem + 1.

verticalRestricitons(_, Size, _, Size).
verticalRestricitons(Solved, Row, Size, Size):-
  Row1 is Row + 1,
  (ver(Row,Size,Color) ->
    getCell(Solved, Row, Size, Elem),
    getCell(Solved, Row1, Size, ElemDown),
    if(Color == black, double(Elem, ElemDown), consecutive(Elem, ElemDown));
    true),
  verticalRestricitons(Solved, Row1, 1, Size).

verticalRestricitons(Solved, Row, Col, Size):-
  Col1 is Col + 1,
  Row1 is Row + 1,
  (ver(Row,Col,Color) ->
    getCell(Solved, Row, Col, Elem),
    getCell(Solved, Row1, Col, ElemDown),
    if(Color == black, double(Elem, ElemDown), consecutive(Elem, ElemDown)); true),
  verticalRestricitons(Solved, Row,Col1,Size).

horizontalRestricitons(_, Size, Size, Size).

horizontalRestricitons(Solved, Row, Size, Size):-
  Row1 is Row + 1,
  horizontalRestricitons(Solved, Row1, 1, Size).

horizontalRestricitons(Solved, Row, Col, Size):-
  Col1 is Col + 1,
  (hor(Row,Col,Color) ->
    getCell(Solved, Row, Col, Elem),
    getCell(Solved, Row, Col1, ElemRight),
    if(Color == black, double(Elem, ElemRight), consecutive(Elem, ElemRight));
    true),
  horizontalRestricitons(Solved, Row,Col1,Size).



dotRestrictions(Solved,Size):-
  verticalRestricitons(Solved, 1, 1, Size),
  horizontalRestricitons(Solved, 1, 1, Size).

solveBoard(Board, Solved):-
  length(Board,Size),
  append(Board, L1),
  domain(L1, 1, Size),
  rowRestrictions(Board),
  transpose(Board, NewBoard1),
  rowRestrictions(NewBoard1),
  transpose(NewBoard1, Solved),
  dotRestrictions(Solved, Size),
  append(Solved, L),
  statistics(walltime,_),
  labeling([ffc,bisect], L),
  statistics(walltime,[_,T]),
  assert(time(T)).
