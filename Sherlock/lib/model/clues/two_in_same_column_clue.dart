import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';
import 'package:untitled/model/game_state.dart';

class TwoInSameColumnClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 0;

  @override
  String get description => "These two items should be placed in same column";

  TwoInSameColumnClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2;
    do {
      line2 = random.nextInt(6);
    } while (line1 == line2);
    int position1 = random.nextInt(6);
    int item1 = board.getCell(line1, position1).correctItem;
    int item2 = board.getCell(line2, position1).correctItem;
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    bool isApplied = false;
    for (int i=0; i<6; i++) {
      GameState firstState = board.getCell(first.line, i).currentState;
      GameState secondState = board.getCell(second.line, i).currentState;
      if (!firstState.hasPossibleItem(first.number) && secondState.hasPossibleItem(second.number)) {
        secondState.removeItem(second.number);
        isApplied = true;
      }
      if (!secondState.hasPossibleItem(second.number) && firstState.hasPossibleItem(first.number)) {
        firstState.removeItem(first.number);
        isApplied = true;
      }
      if (firstState.isResolvedTo(first.number)) {
        secondState.resolveWith(second.number);
      }
      if (secondState.isResolvedTo(second.number)) {
        firstState.resolveWith(first.number);
      }
    }
    return isApplied;  }

  bool operator ==(clue) {
    return clue is TwoInSameColumnClue && equalsPair([first, second], [clue.first, clue.second]);
  }
}