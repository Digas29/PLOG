createDots(_, Size, Size, Size).

createDots(Board, Size, Col, Size):-
  Col1 is Col + 1,
  getCell(Board, Size, Col, Elem),
  getCell(Board, Size, Col1, ElemRight),
  dotRight(Size, Col, Elem, ElemRight),
  createDots(Board, Size, Col1, Size).

createDots(Board, Row, Size, Size):-
  Row1 is Row + 1,
  getCell(Board, Row, Size, Elem),
  getCell(Board, Row1, Size, ElemDown),
  dotDown(Row, Size, Elem, ElemDown),
  createDots(Board, Row1, 1, Size).

createDots(Board, Row, Col, Size):-
  Row1 is Row + 1,
  Col1 is Col + 1,
  getCell(Board, Row, Col, Elem),
  getCell(Board, Row, Col1, ElemRight),
  getCell(Board, Row1, Col, ElemDown),
  dotRight(Row, Col, Elem, ElemRight),
  dotDown(Row, Col, Elem, ElemDown),
  createDots(Board, Row, Col1, Size).

dotRight(Row, Col, Elem, ElemRight):-
  Elem1 is Elem + 1,
  ElemRight1 is ElemRight + 1,
  Elem2 is Elem * 2,
  ElemRight2 is ElemRight * 2,
  if(Elem2 == ElemRight, assert(hor(Row,Col,black)), true),
  if(Elem == ElemRight2, assert(hor(Row,Col,black)), true),
  if(Elem1 == ElemRight, assert(hor(Row,Col,white)), true),
  if(Elem == ElemRight1, assert(hor(Row,Col,white)), true).

dotDown(Row, Col, Elem, ElemDown):-
  Elem1 is Elem + 1,
  ElemDown1 is ElemDown + 1,
  Elem2 is Elem * 2,
  ElemDown2 is ElemDown * 2,
  if(Elem2 == ElemDown, assert(ver(Row,Col,black)), true),
  if(Elem == ElemDown2, assert(ver(Row,Col,black)), true),
  if(Elem1 == ElemDown, assert(ver(Row,Col,white)), true),
  if(Elem == ElemDown1, assert(ver(Row,Col,white)), true).
