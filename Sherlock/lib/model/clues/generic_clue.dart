import 'package:untitled/model/game_field.dart';

abstract class GenericClue {
  String get description;
  int get sortOrder;

  GenericClue equalsTo(GenericClue clue);

  bool applyToField(GameField board);

  static GenericClue generateClue(GameField board) {

  }
}