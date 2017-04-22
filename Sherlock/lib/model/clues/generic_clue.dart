import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/game_field.dart';

abstract class GenericClue {
  String get description;
  int get sortOrder;

  GenericClue.generate(GameField board);

  bool applyToField(GameField board);

  bool equalsPair(List<ClueItem> items1, List<ClueItem> items2) {
    if (items1.length != 2 || items2.length != 2) {
      return false;
    }
    return (items1.first == items2.first && items1.last == items2.last)
        || (items1.first == items2.last && items1.last == items2.first);
  }
}