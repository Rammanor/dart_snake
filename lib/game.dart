import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'keyboard.dart';
import 'snake.dart';
import 'board.dart';

class Game {
  final Board _board;
  final Keyboard _keyboard;

	// smaller numbers make the game run faster
  static const num GAME_SPEED = 50;
  num _lastTimeStamp = 0;
  
  Snake _snake;  
	Point _food;

  bool _stopped = false;
  
  Game(this._board, this._keyboard) {}

  Future run() async {  
    update(await window.animationFrame);
  }
  
  void update(num delta) {
    if (isStooped()) { return; }
    final num diff = delta - _lastTimeStamp;

    if (diff > GAME_SPEED) {
      _lastTimeStamp = delta;
      _board.clear();
      _board.drawCell(_food, "blue");
      _checkInput();
      _snake.update();
      _checkForCollisions();
    }

    // keep looping
    run();
  }

  void start() {
    init();
    run();
  }

  void continueGame() {
    _stopped = false;
    run();
  }

  void stop() {
    _stopped = true;
  }

  bool isStooped() {
    return _stopped;
  }

  void _checkInput() {  
    if (_keyboard.isPressed(KeyCode.LEFT)) {
      _snake.changeDirection(LEFT);
    }
    else if (_keyboard.isPressed(KeyCode.RIGHT)) {
      _snake.changeDirection(RIGHT);
    }
    else if (_keyboard.isPressed(KeyCode.UP)) {
      _snake.changeDirection(UP);
    }
    else if (_keyboard.isPressed(KeyCode.DOWN)) {
      _snake.changeDirection(DOWN);
    }
  }

  
  void init() {  
    _snake = new Snake(_board);
    _food = _board.randomPoint();
  }
  
  void _checkForCollisions() {  
    // check for collision with food
    if (_snake.head == _food) {
      _snake.grow();
      _food = _board.randomPoint();
    }

    // check death conditions
    if (_snake.head.x <= -1 ||
      _snake.head.x >= _board.rightEdgeX ||
      _snake.head.y <= -1 ||
      _snake.head.y >= _board.bottomEdgeY ||
      _snake.checkForBodyCollision()) {
      init();
    }
  }
}