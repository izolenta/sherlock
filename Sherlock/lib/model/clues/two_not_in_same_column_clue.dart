import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoNotInSameColumnClue extends GenericClue {

  ClueItem first;
  ClueItem second;

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
  int get sortOrder => 5;
  @override
  bool applyToField(GameField board) {
    // TODO: implement applyToField
  }

  bool operator(clue) {
    return clue is TwoNotInSameColumnClue && equalsPair([first, second], [clue.first, clue.second]);
  }
}