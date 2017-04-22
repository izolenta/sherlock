import 'dart:math';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_state.dart';

class TwoWithNoThirdAtCenterClue extends GenericClue {

  ClueItem first;
  ClueItem second;
  ClueItem third;

  @override
  int get sortOrder => 6;

  @override
  String get description =>  "First and third items should be placed adjacent to some other item, they can be reversed, and center item should NOT be second one";

  TwoWithNoThirdAtCenterClue.generate(GameField board) : super.generate(board) {
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

    int newPosition3;
    do {
      newPosition3 = random.nextInt(6);
    } while(newPosition3 == position3);

    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position2).correctItem;
    int item3 = board.getCell(line3, newPosition3).correctItem;

    first = new ClueItem(line1, item1);
    second = new ClueItem(line2, item2);
    third = new ClueItem(line3, item3);
  }

  @override
  bool applyToField(GameField board) {
    return _checkSpaced(first, second, third, board) || _checkSpaced(second, first, third, board);
  }

  bool _checkSpaced(ClueItem first, ClueItem second, ClueItem centered, GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState stateFirst = board.getCell(first.line, i).currentState;
      if (stateFirst.hasPossibleItem(first.number)) {
        bool adjacentFound = false;
        if (i > 1) {
          GameState stateThird = board.getCell(third.line, i-1).currentState;
          GameState stateSecond = board.getCell(second.line, i-2).currentState;
          if (stateSecond.hasPossibleItem(second.number) && !stateThird.isResolvedTo(third.number)) {
            adjacentFound = true;
          }
        }
        if (!adjacentFound && i < 4) {
          GameState stateSecond = board.getCell(second.line, i+2).currentState;
          GameState stateThird = board.getCell(third.line, i+1).currentState;
          if (stateSecond.hasPossibleItem(second.number) && !stateThird.isResolvedTo(third.number)) {
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
    return clue is TwoWithNoThirdAtCenterClue
        && clue.third == third
        && equalsPair([clue.first, clue.second], [first, second]);
  }
}