import 'dart:async';
import 'dart:html';

import 'food.dart';
import 'keyboard.dart';
import 'snake.dart';
import 'board.dart';

class Game {
  final Board _board;
  final Keyboard _keyboard;

  int score = 0;

  StreamController<int> scoreStream = new StreamController<int>();

	// smaller numbers make the game run faster
  static num GAME_SPEED = 50;
  num _lastTimeStamp = 0;
  
  Snake _snake;  
	Food _food;

  bool _stopped = false;
  
  Game(this._board, this._keyboard) {
    scoreStream.onListen = () => scoreStream.add(score);
  }

  Future run() async {  
    update(await window.animationFrame);
  }
  
  void update(num delta) {
    if (isStooped()) { return; }
    final num diff = delta - _lastTimeStamp;

    if (diff > GAME_SPEED) {
      _lastTimeStamp = delta;
      _board.clear();
      _food.drawFood();
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

  void slowDown() {
    GAME_SPEED *= 2;
    print(GAME_SPEED);
  }

  void speedUp() {
    GAME_SPEED ~/= 2;
    print(GAME_SPEED);
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
    } else if (_keyboard.isPressed(KeyCode.NUM_PLUS)) {
      speedUp();
    } else if (_keyboard.isPressed(KeyCode.NUM_MINUS)) {
      slowDown();
    }
  }

  Stream<int> getScoreStream() {
    return scoreStream.stream;
  }
  
  void init() {
    score = 0;
    scoreStream.add(score);
    _snake = new Snake(_board);
    _food = new Food(_board);
    _food.generateFood();
  }
  
  void _checkForCollisions() {  
    // check for collision with food
    var food_points = _food.hasEaten(_snake.head);

    if (food_points > 0) {
      score += food_points;
      scoreStream.add(score);
      _snake.grow();
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