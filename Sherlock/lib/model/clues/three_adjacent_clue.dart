import 'dart:math';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_state.dart';

class ThreeAdjacentClue extends GenericClue {

  ClueItem first;
  ClueItem second;
  ClueItem third;

  @override
  int get sortOrder => 2;

  @override
  String get description => "Items {0}, {2} and {1} should be placed in adjacent columns. The order can be changed, but {2} should be always in the middle, i.e. <nobr>{0}{2}{1}</nobr> or <nobr>{1}{2}{0}</nobr>.<br>"
  "Also this means that {2} cannot be in most left and most right columns.";

  ThreeAdjacentClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int line3 = random.nextInt(6);
    int position3 = random.nextInt(4)+1;
    int position1 = position3-1;
    int position2 = position3+1;
    if (random.nextInt(2) == 1) {
      int temp = position1;
      position1 = position2;
      position2 = temp;
    }
    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position2).correctItem;
    int item3 = board.getCell(line3, position3).correctItem;

    first = new ClueItem(line1, item1);
    second = new ClueItem(line2, item2);
    third = new ClueItem(line3, item3);
  }

  @override
  bool applyToField(GameField board) {
    bool isApplied = _checkCenterItemNotAtBounds(third, board);
    isApplied = isApplied || _checkThreeAdjacent(first, second, third, board);
    isApplied = isApplied || _checkThreeAdjacent(second, first, third, board);
    return isApplied;
  }

  bool _checkCenterItemNotAtBounds(ClueItem center, GameField board) {
    bool isApplied = false;
    GameState stateThird = board.getCell(center.line, 0).currentState;
    if (stateThird.hasPossibleItem(center.number)) {
      stateThird.removeItem(center.number);
      isApplied = true;
    }
    stateThird = board.getCell(center.line, 5).currentState;
    if (stateThird.hasPossibleItem(center.number)) {
      stateThird.removeItem(center.number);
      isApplied = true;
    }
    return isApplied;
  }

  bool _checkThreeAdjacent(ClueItem first, ClueItem second, ClueItem centered, GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState stateFirst = board.getCell(first.line, i).currentState;
      if (stateFirst.hasPossibleItem(first.number)) {
        bool adjacentFound = false;
        if (i > 1) {
          GameState stateThird = board.getCell(third.line, i-1).currentState;
          GameState stateSecond = board.getCell(second.line, i-2).currentState;
          if (stateSecond.hasPossibleItem(second.number) && stateThird.hasPossibleItem(third.number)) {
            adjacentFound = true;
          }
        }
        if (!adjacentFound && i < 4) {
          GameState stateSecond = board.getCell(second.line, i+2).currentState;
          GameState stateThird = board.getCell(third.line, i+1).currentState;
          if (stateSecond.hasPossibleItem(second.number) && stateThird.hasPossibleItem(third.number)) {
            adjacentFound = true;
          }
        }
        if (!adjacentFound) {
          stateFirst.removeItem(first.number);
          isApplied = true;
        }
      }
    }
    return isApplied;
  }

  bool operator ==(clue) {
    return clue is ThreeAdjacentClue
        && clue.third ==  third
        && equalsPair([clue.first, clue.second], [first, second]);
  }

  @override
  String toString() {
    return "ThreeAdjacent: ${first.line}:${first.number}, ${third.line}:${third.number}, ${second.line}:${second.number}";
  }

}