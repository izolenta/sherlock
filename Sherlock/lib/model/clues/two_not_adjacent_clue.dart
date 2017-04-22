import 'dart:math';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_state.dart';

class TwoNotAdjacentClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 4;

  @override
  String get description => "The first item should NOT be placed adjacent to second one";

  TwoNotAdjacentClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int position1 = random.nextInt(6);
    List<int> adjacents = [];
    if (position1 > 0) {
      adjacents.add(board.getCell(line2, position1-1).correctItem);
    }
    if (position1 < 5) {
      adjacents.add(board.getCell(line2, position1+1).correctItem);
    }
    int item1 = board.getCell(line1, position1).correctItem;
    int item2;
    do {
      item2 = random.nextInt(6);
    } while (adjacents.contains(item2));
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    return _checkNotAdjacent(first, second, board) || _checkNotAdjacent(second, first, board);
  }

  bool _checkNotAdjacent(ClueItem first, ClueItem second, GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState stateFirst = board.getCell(first.line, i).currentState;
      if (stateFirst.isResolvedTo(first.number)) {
        if (i > 0) {
          GameState stateSecond = board.getCell(second.line, i - 1).currentState;
          if (stateSecond.hasPossibleItem(second.number)) {
            stateSecond.removeItem(second.number);
            isApplied = true;
          }
        }
        if (i < 5) {
          GameState stateSecond = board.getCell(second.line, i + 1).currentState;
          if (stateSecond.hasPossibleItem(second.number)) {
            stateSecond.removeItem(second.number);
            isApplied = true;
          }
        }
      }
    }
    return isApplied;
  }

  bool operator ==(clue) {
    return clue is TwoNotAdjacentClue && equalsPair([first, second], [clue.first, clue.second]);
  }
}