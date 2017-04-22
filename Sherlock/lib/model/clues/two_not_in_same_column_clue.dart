import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class TwoNotInSameColumnClue extends GenericClue {

  final ClueItem first;
  final ClueItem second;

  @override
  String get description => "These two items should NOT be placed in same column";

  TwoNotInSameColumnClue(this.first, this.second);

  @override
  int get sortOrder => 5;
  @override
  bool applyToField(GameField board) {
    // TODO: implement applyToField
  }

  @override
  GenericClue equalsTo(GenericClue clue) {
    // TODO: implement equalsTo
  }
}