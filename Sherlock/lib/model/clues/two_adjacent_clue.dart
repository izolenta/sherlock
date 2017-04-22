import 'dart:math';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_state.dart';

class TwoAdjacentClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 1;

  @override
  String get description => "The first item should be placed adjacent to second one";

  TwoAdjacentClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int position1 = random.nextInt(5);
    int position2 = position1+1;
    if (random.nextInt(2) == 1) {
      int temp = position1;
      position1 = position2;
      position2 = temp;
    }
    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position2).correctItem;
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    return checkAdjacent(first, second, board) || checkAdjacent(second, first, board);
  }

  bool checkAdjacent(ClueItem first, ClueItem second, GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState stateFirst = board.getCell(first.line, i).currentState;
      if (stateFirst.hasPossibleItem(first.number)) {
        bool adjacentFound = false;
        if (i > 0) {
          GameState stateSecond = board.getCell(second.line, i-1).currentState;
          if (stateSecond.hasPossibleItem(second.number)) {
            adjacentFound = true;
          }
        }
        if (!adjacentFound && i < 5) {
          GameState stateSecond = board.getCell(second.line, i+1).currentState;
          if (stateSecond.hasPossibleItem(second.number)) {
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
    return clue is TwoAdjacentClue && equalsPair([first, second], [clue.first, clue.second]);
  }

  @override
  String toString() {
    return "TwoAdjacent: ${first.line}:${first.number}, ${second.line}:${second.number}";
  }

}