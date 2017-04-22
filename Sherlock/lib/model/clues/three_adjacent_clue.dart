import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';

class ThreeAdjacentClue extends GenericClue {

  final ClueItem first;
  final ClueItem second;
  final ClueItem third;

  @override
  int get sortOrder => 2;

  @override
  String get description => "These three items should be adjacent, but 1st and 3rd can be reversed";

  ThreeAdjacentClue(this.first, this.second, this.third);
  @override
  bool applyToField(GameField board) {
    // TODO: implement applyToField
  }

  @override
  GenericClue equalsTo(GenericClue clue) {
    // TODO: implement equalsTo
  }
}