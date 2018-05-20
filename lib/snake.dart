import 'dart:html';

import 'board.dart';

class Snake {
  static const int START_LENGTH = 6;  
  // coordinates of the body segments
	List<Point> _body;
  // current travel direction
  Point _dir = RIGHT; 
	// directions
  

  final Board _board;
  
  Snake(this._board) {  
    int i = START_LENGTH - 1;
    _body = new List<Point>.generate(START_LENGTH,
      (int index) => new Point(i--, 0));
  }
  
  Point get head => _body.first;
  
  void changeDirection(Point dir) {
    if (dir == LEFT && _dir != RIGHT) {
      _dir = dir;
    }
    else if (dir == RIGHT && _dir != LEFT) {
      _dir = dir;
    }
    else if (dir == UP && _dir != DOWN) {
      _dir = dir;
    }
    else if (dir == DOWN && _dir != UP) {
      _dir = dir;
    }
  }
  
  void grow() {  
    // add new head based on current direction
    _body.insert(0, head + _dir);
  }
  
  void _move() {  
    // add a new head segment
    grow();

    // remove the tail segment
    _body.removeLast();
  }
  
  void _draw() {  
    // starting with the head, draw each body segment
    for (Point p in _body) {
      _board.drawCell(p, "green");
    }
  }
  
  bool checkForBodyCollision() {  
    for (Point p in _body.skip(1)) {
      if (p == head) {
        return true;
      }
    }
    return false;
  }
  
  void update() {  
    _move();
    _draw();
  }
}