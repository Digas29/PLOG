tabuleiro([0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0]).

convertToChar(Number, Char) :- (Number =:= 0 -> Char = ' '; Number =:= -1 -> Char = 'O'; Char  = 'X').
getCell(Column, Row, Cell) :- 
Column > -1, Column < 11, Row > -1, Row < 11,
N is Row * 11 + Column,
tabuleiro(L1),
nth0(N, L1, Cell).


printAux(N) :- 
Total is 11*11,
N < Total,
Resto is N mod 10,
nth0(N, L1, Cell),
tabuleiro(L1),
convertToChar(Cell,Char),
write(char)
(Resto =:= 0 -> write(\n);),
printAux(N+1).

printTabuleiro() :- printAux(0).