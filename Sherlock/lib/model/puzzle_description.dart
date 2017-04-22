import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';

class PuzzleDescription {
  final GameField board;
  final List<GenericClue> ruleSet;
  final int id;

  PuzzleDescription(this.id, this.board, this.ruleSet);
}