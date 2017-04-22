import 'dart:math';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoNotAdjacentClue extends GenericClue {

  ClueItem first;
  ClueItem second;

  @override
  int get sortOrder => 4;

  @override
  String get description => "The first item should NOT be placed adjacent to second one";

  TwoNotAdjacentClue.generate(GameField board) : super.generate(board) {
    Random random = new Random();
    int line1 = random.nextInt(6);
    int line2 = random.nextInt(6);
    int position1 = random.nextInt(6);
    List<int> adjacents = [];
    if (position1 > 0) {
      adjacents.add(board.getCell(line2, position1-1).correctItem);
    }
    if (position1 < 5) {
      adjacents.add(board.getCell(line2, position1+1).correctItem);
    }
    int item1 = board.getCell(line1, position1).correctItem;
    int item2;
    do {
      item2 = random.nextInt(6);
    } while (adjacents.contains(item2));
    first = new ClueItem(line1, item1);
    second =  new ClueItem(line2, item2);
  }

  @override
  bool applyToField(GameField board) {
    // TODO: implement applyToField
  }

  @override
  bool equalsTo(GenericClue clue) {
    return clue is TwoNotAdjacentClue && first.equalsTo(clue.first) && second.equalsTo(clue.second);
  }
}