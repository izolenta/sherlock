import 'package:untitled/model/game_cell.dart';
import 'package:untitled/model/game_line.dart';
import 'package:untitled/util/cloneable.dart';

class GameField implements Cloneable {
  List<GameLine> _lines = [];

  List<GameLine> get lines => _lines;

  GameField.initial() {
    _lines.clear();
    for (int i = 0; i < 6; i++) {
      _lines.add(new GameLine.initial());
    }
  }

  GameField.fromArray(List<GameLine> array) {
    _lines.clear();
    for (GameLine next in array) {
      _lines.add(next.clone());
    }
  }

  GameCell getCell(int line, int column) {
    return lines[line].cells[column];
  }

  @override
  Cloneable clone() {
    return new GameField.fromArray(lines);
  }
}