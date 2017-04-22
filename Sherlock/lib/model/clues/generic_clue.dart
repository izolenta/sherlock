import 'package:untitled/model/game_field.dart';

abstract class GenericClue {
  String get description;
  int get sortOrder;

  bool applyToField(GameField board);
  bool equalsTo(GenericClue);

  static GenericClue generateClue(GameField board) {

  }
}