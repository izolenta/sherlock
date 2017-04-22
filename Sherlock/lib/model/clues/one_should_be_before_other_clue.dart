import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class OneShouldBeBeforeOtherClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 3;

  @override
  String get description => "The first item should be placed before (at left of) the second";

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
    // TODO: implement applyToField
  }

  @override
  bool equalsTo(GenericClue clue) {
    return clue is OneShouldBeBeforeOtherClue && first.equalsTo(clue.first) && second.equalsTo(clue.second);
  }
}