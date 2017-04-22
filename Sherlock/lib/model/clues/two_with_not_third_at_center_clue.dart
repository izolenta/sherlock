import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoWithNoThirdAtCenterClue extends GenericClue {

  final ClueItem first;
  final ClueItem second;
  final ClueItem third;

  @override
  String get description =>  "First and third items should be placed adjacent to some other item, they can be reversed, and center item should NOT be second one";

  @override
  int get sortOrder => 6;

  TwoWithNoThirdAtCenterClue(this.first, this.second, this.third);

  @override
  bool applyToField(GameField board) {
    // TODO: implement applyToField
  }

  @override
  GenericClue equalsTo(GenericClue clue) {
    // TODO: implement equalsTo
  }
}