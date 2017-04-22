import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoInSameColumnClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  String get description => "These two items should be placed in same column";

  @override
  int get sortOrder => 0;

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
    // TODO: implement applyToField
  }

  @override
  bool equalsTo(GenericClue clue) {
    return clue is TwoInSameColumnClue && first.equalsTo(clue.first) && second.equalsTo(clue.second);
  }
}