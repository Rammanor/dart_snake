import 'dart:html';
import 'dart:math';

const Point LEFT = const Point(-1, 0);  
const Point RIGHT = const Point(1, 0);  
const Point UP = const Point(0, -1);  
const Point DOWN = const Point(0, 1);

class Board {
  final int CELL_SIZE = 10; 

  CanvasElement canvas;  
  CanvasRenderingContext2D ctx;

  num rightEdgeX;
  num bottomEdgeY;

  Board() {
    canvas = querySelector('#canvas');
    ctx = canvas.getContext('2d');

    rightEdgeX = canvas.width ~/ CELL_SIZE;
    bottomEdgeY = canvas.height ~/ CELL_SIZE;
  }

  void drawCell(Point coords, String color) {
    ctx..fillStyle = color
      ..strokeStyle = "white";

    final int x = coords.x * CELL_SIZE;
    final int y = coords.y * CELL_SIZE;

    ctx..fillRect(x, y, CELL_SIZE, CELL_SIZE);
      // ..strokeRect(x, y, CELL_SIZE, CELL_SIZE);
  }

   Point randomPoint() {
    Random random = new Random();
    return new Point(random.nextInt(rightEdgeX),
      random.nextInt(bottomEdgeY));
  }

  void clear() {  
    ctx..fillStyle = "white"
      ..fillRect(0, 0, canvas.width, canvas.height);
  }
}