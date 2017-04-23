import 'dart:math';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_state.dart';

class OneShouldBeBeforeOtherClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 3;

  @override
  String get description => "The item {0} should be placed in the column to the left (not necessarily <i>adjacent</i> left) of {1}<br>"
  "Also this means that {0} cannot be in most right column, and {1} cannot be at most left column.";

  OneShouldBeBeforeOtherClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int position1 = random.nextInt(5);
    int position2 = random.nextInt(5 - position1) + position1 + 1;
    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position2).correctItem;
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    bool isApplied = false;
    int mostLeft = 0;
    int mostRight = 5;
    for (int i=0; i<6; i++) {
      GameState next = board.getCell(first.line, i).currentState;
      if (next.hasPossibleItem(first.number)) {
        mostLeft = i;
        break;
      }
    }
    for (int i=5; i>-1; i--) {
      GameState next = board.getCell(second.line, i).currentState;
      if (next.hasPossibleItem(second.number)) {
        mostRight = i;
        break;
      }
    }
    for (int i=0; i<=mostLeft; i++) {
      GameState next = board.getCell(second.line, i).currentState;
      if (next.hasPossibleItem(second.number)) {
        next.removeItem(second.number);
        isApplied = true;
      }
    }
    for (int i=5; i>=mostRight; i--) {
      GameState next = board.getCell(first.line, i).currentState;
      if (next.hasPossibleItem(first.number)) {
        next.removeItem(first.number);
        isApplied = true;
      }
    }
    return isApplied;
  }

  bool operator ==(clue) {
    return clue is OneShouldBeBeforeOtherClue && first == clue.first && second == clue.second;
  }

  @override
  String toString() {
    return "OneShouldBeBeforeOther: ${first.line}:${first.number}, ${second.line}:${second.number}";
  }
}