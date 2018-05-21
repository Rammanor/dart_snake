import 'board.dart';
import 'dart:async';
import 'dart:math';
  
const NORMAL_POINTS = 10;
const MEGA_POINTS = 100;

class Food {

  Point _normal_food;

  Point _mega_food;

  Future mega_food_future;

  final Board _board;

  Food(this._board) {}

  void generateFood() {
    _generateNormalFood();
    _generateMegaFood();
  }

  void drawFood() {
    _board.drawCell(_normal_food, 'blue');
    _board.drawCell(_mega_food, 'red');
  }

  void _generateNormalFood() {
    _normal_food = _board.randomPoint();
  }

  void _generateMegaFood() {
    _mega_food = _board.randomPoint();

    mega_food_future = new Future.delayed(const Duration(seconds: 5), () {
      _generateMegaFood();
    });
  }

  hasEaten(Point snake_head) {
    if (snake_head == _normal_food) {
      _generateNormalFood();
      return NORMAL_POINTS;
    } else if (snake_head == _mega_food) {
      _generateMegaFood();
      return MEGA_POINTS;
    }

    return 0;
  }
}