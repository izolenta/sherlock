import 'dart:math';
import 'package:untitled/model/game_cell.dart';
import 'package:untitled/model/game_line.dart';
import 'package:untitled/util/cloneable.dart';

class GameField implements Cloneable {
  List<GameLine> _lines = [];

  List<GameLine> get lines => _lines;
  bool get isResolved => getNotResolvedCellCount() == 0;

  int get openedCells => 36 - getNotResolvedCellCount();

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

  int getNotResolvedCellCount() {
    num result = 0;
    for (int i=0; i<6; i++) {
      for (int j=0; j<6; j++) {
        if (!getCell(i, j).currentState.isResolved) {
          result++;
        }
      }
    }
    return result;
  }

  void optimizeBoard() {
    //printCorrectState();
    int cnt=0;
    for (var line in lines) {
      line.optimizeLine(cnt++);
    }
  }

  void printCorrectState() {
    int cnt = 0;
    for (GameLine line in lines) {
      print(
          "$cnt${line.cells[0].correctItem} "
              "$cnt${line.cells[1].correctItem} "
              "$cnt${line.cells[2].correctItem} "
              "$cnt${line.cells[3].correctItem} "
              "$cnt${line.cells[4].correctItem} "
              "$cnt${line.cells[5].correctItem}");
      cnt++;
    }
  }

  void printCurrentState() {
    for (GameLine line in lines) {
      print(
          "${_getArray(line.cells[0].currentState.state)} "
              "${_getArray(line.cells[1].currentState.state)} "
              "${_getArray(line.cells[2].currentState.state)} "
              "${_getArray(line.cells[3].currentState.state)} "
              "${_getArray(line.cells[4].currentState.state)} "
              "${_getArray(line.cells[5].currentState.state)}");
    }
  }

  List<int> _getArray(int state) {
    List<int> result = [];
    for (int i=0; i<6; i++) {
      if (state & pow(2, i) != 0) {
        result.add(i);
      }
    }
    return result;
  }
}