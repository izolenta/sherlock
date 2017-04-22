import 'dart:math';
import 'package:untitled/model/game_cell.dart';
import 'package:untitled/util/cloneable.dart';

class GameLine implements Cloneable {

  List<GameCell> _cells = [];
  List<GameCell> get cells => _cells;

  GameLine.initial() {
    _cells.clear();
    List<int> result = createRandomConfiguration();
    for (int next in result) {
      _cells.add(new GameCell.initial(next));
    }
  }

  GameLine.fromArray(List<GameCell> array) {
    _cells.clear();
    for (GameCell next in array) {
      _cells.add(next.clone());
    }
  }

  List<int> createRandomConfiguration() {
    List<int> result = [0,1,2,3,4,5];
    Random random = new Random();
    for (int i=0; i<30; i++) {
      int newPosition = random.nextInt(6);
      int temp = result[i%6];
      result[i%6] = result[newPosition];
      result[newPosition] = temp;
    }
    return result;
  }

  @override
  Cloneable clone() {
    return new GameLine.fromArray(cells);
  }
}