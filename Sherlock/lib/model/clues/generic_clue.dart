import 'package:untitled/model/game_field.dart';

abstract class GenericClue {
  String get description;
  int get sortOrder;

  GenericClue.generate(GameField board);

  bool equalsTo(GenericClue clue);
  bool applyToField(GameField board);
}