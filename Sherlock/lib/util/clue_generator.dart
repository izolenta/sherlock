import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/clues/one_should_be_before_other_clue.dart';
import 'package:sherlock/model/clues/three_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_in_same_column_clue.dart';
import 'package:sherlock/model/clues/two_not_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_not_in_same_column_clue.dart';
import 'package:sherlock/model/clues/two_with_not_third_at_center_clue.dart';
import 'package:sherlock/model/game_field.dart';

class ClueGenerator {
  static List<GenericClue> generateClueSet(GameField board, int difficulty) {

    List<GenericClue> clues = [];
    for (int i=0; i<10 + difficulty * 4; i++) {
      TwoInSameColumnClue clue;
      do {
        clue = new TwoInSameColumnClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number} same column ${clue.second.line}${clue.second.number}");
    }
    for (int i=0; i<10; i++) {
      TwoAdjacentClue clue;
      do {
        clue = new TwoAdjacentClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number} adjacent to ${clue.second.line}${clue.second.number}");
    }
    for (int i=0; i<5; i++) {
      OneShouldBeBeforeOtherClue clue;
      do {
        clue = new OneShouldBeBeforeOtherClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number} is at left of ${clue.second.line}${clue.second.number}");
    }
    for (int i=0; i<5; i++) {
      ThreeAdjacentClue clue;
      do {
        clue = new ThreeAdjacentClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number}, ${clue.third.line}${clue.third.number}, ${clue.second.line}${clue.second.number} are adjacent");
    }
    for (int i=0; i<5; i++) {
      TwoNotAdjacentClue clue;
      do {
        clue = new TwoNotAdjacentClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number} not adjacent to ${clue.second.line}${clue.second.number}");
    }
    for (int i=0; i<5; i++) {
      TwoNotInSameColumnClue clue;
      do {
        clue = new TwoNotInSameColumnClue.generate(board);
      } while (clues.contains(clue));
      clues.add(clue);
//      print("${clue.first.line}${clue.first.number} not in column with ${clue.second.line}${clue.second.number}");
    }
//    for (int i=0; i<5; i++) {
//      TwoWithNoThirdAtCenterClue clue;
//      do {
//        clue = new TwoWithNoThirdAtCenterClue.generate(board);
//      } while (clues.contains(clue));
//      clues.add(clue);
////      print("${clue.first.line}${clue.first.number} - (X${clue.third.line}${clue.third.number}X) - ${clue.second.line}${clue.second.number}");
//    }
    return clues;
  }
}