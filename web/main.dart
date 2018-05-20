
import 'dart:html';
import 'package:snake/keyboard.dart';
import 'package:snake/board.dart';
import 'package:snake/game.dart';


void main() {   
  final _game = new Game(new Board(), new Keyboard());

  final HtmlElement start_btn = querySelector('#start-btn');
  final HtmlElement stop_btn = querySelector('#stop-btn');
  final HtmlElement continue_btn = querySelector('#continue-btn');

  start_btn.onClick.listen((Event e) => _game.start());
  stop_btn.onClick.listen((Event e) => _game.stop());
  continue_btn.onClick.listen((Event e) => _game.continueGame());
}



