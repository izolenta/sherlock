import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoWithNoThirdAtCenterClue extends GenericClue {

  ClueItem first;
  ClueItem second;
  ClueItem third;

  @override
  String get description =>  "First and third items should be placed adjacent to some other item, they can be reversed, and center item should NOT be second one";

  @override
  int get sortOrder => 6;

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
    // TODO: implement applyToField
  }

  bool operator ==(clue) {
    return clue is TwoWithNoThirdAtCenterClue
        && clue.third == third
        && equalsPair([clue.first, clue.second], [first, second]);
  }
}