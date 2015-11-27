:- use_module(library(random)).
bot(Dif, Player,Board, R, C, Round):-
  (Dif == 1 -> botRandom(R, C,Board, Player,Round);
  botGreedy(Board, Player, R, C,Round)).

botRandom(R, C, Board, Player,Round):-
  Round == 1,
  validFirstMoves(Board, Player, Moves),
  length(Moves,Len),
  Max is Len - 1,
  random(0, Max, Index),
  getMove(Index, Moves, [R | [C | Tail]]);
  Round == 2,
  validSecondMoves(Board, Player, Moves),
  length(Moves,Len),
  Max is Len - 1,
  random(0, Max, Index),
  getMove(Index, Moves, [R | [C | Tail]]).

botGreedy(Board, Player, R, C,Round):-
  Round == 1,
  validFirstMoves(Board, Player, Moves),
  evaluateMoves(Moves,Board, Player, Points),
  maximum_at(Points,_,Index),
  getMove(Index, Moves, [R | [C | Tail]]);
  Round == 2,
  validSecondMoves(Board, Player, Moves),
  evaluateMoves(Moves,Board, Player, Points),
  maximum_at(Points,_,Index),
  getMove(Index, Moves, [R | [C | Tail]]).
