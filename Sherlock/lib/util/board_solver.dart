import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_field.dart';

class BoardSolver {
  static void trySolve(GameField board, List<GenericClue> clues) {
    while(true) {
      bool isApplied = false;
      for (GenericClue clue in clues) {
        if (clue.applyToField(board)) {
          isApplied = true;
//          print("Clue applied: "+clue.toString());
          board.optimizeBoard();
//          board.printCurrentState();
        }
      }
      if (isApplied) {
        if (board.isResolved) {
//          print("RESOLVED!!! in $step steps");
//          board.printCorrectState();
          break;
        }
        else {
//          print("Step $step, Continuing...");
        }
      }
      else
      {
//        print("Shit happens, no solution there. Steps: $step");
        break;
      }
    }
  }

}
