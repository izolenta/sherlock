import 'dart:math';
import 'package:sherlock/model/game_cell.dart';
import 'package:sherlock/model/game_state.dart';
import 'package:sherlock/util/cloneable.dart';

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

  void optimizeLine([lineNumber = -1]) {
    for (int i=0; i<6; i++) {
      int foundAt = _findOnlyPossiblePositionAtLine(i);
      if (foundAt != -1) {
        GameState state = _cells[foundAt].currentState;
        if (!state.isResolved) {
          if (_cells[foundAt].correctItem != i) {
            print("Resolution at line $lineNumber, pos $foundAt should be ${_cells[foundAt].correctItem}, but asked to be $i");
            throw("BAD RESOLUTION!");
          }
          state.resolveWith(i);
        }
      }
    }
    for (int i=0; i<6; i++) {
      if (_cells[i].currentState.isResolved) {
        for (int j=0; j<6; j++) {
          if (j != i) {
            removeItemAndCheckResolved(j, _cells[i].currentState.getResolvedValue(), lineNumber);
          }
        }
      }
    }
  }

  int _findOnlyPossiblePositionAtLine(int item) {
    int position = -1;
    for (int i=0; i<6; i++) {
      if (_cells[i].currentState.hasPossibleItem(item)) {
        if (position == -1) {
          position = i;
        }
        else {
          return -1;
        }
      }
    }
    return position;
  }

  void removeItemAndCheckResolved(int position, int item, int lineNumber) {
    GameState state = _cells[position].currentState;
    if (state.hasPossibleItem(item)) {
      state.removeItem(item);
      if (state.isResolved) {
        optimizeLine(lineNumber);
      }
    }
  }

  @override
  Cloneable clone() {
    return new GameLine.fromArray(cells);
  }
}