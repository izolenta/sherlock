import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';
import 'package:untitled/model/game_state.dart';

class TwoNotInSameColumnClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 5;

  @override
  String get description => "These two items should NOT be placed in same column";

  TwoNotInSameColumnClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int position1 = random.nextInt(6);
    int position2;
    do {
      position2 = random.nextInt(6);
    } while (position1 == position2);
    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position2).correctItem;
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState firstState = board.getCell(first.line, i).currentState;
      GameState secondState = board.getCell(second.line, i).currentState;
      if (firstState.isResolvedTo(first.number) && secondState.hasPossibleItem(second.number)) {
        secondState.removeItem(second.number);
        isApplied = true;
      }
      if (secondState.isResolvedTo(second.number) && firstState.hasPossibleItem(first.number)) {
        firstState.removeItem(first.number);
        isApplied = true;
      }
    }
    return isApplied;
  }

  bool operator(clue) {
    return clue is TwoNotInSameColumnClue && equalsPair([first, second], [clue.first, clue.second]);
  }
}