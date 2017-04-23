import 'dart:math';
import 'package:angular2/angular2.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/game_cell.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/model/game_line.dart';
import 'package:sherlock/model/puzzle_description.dart';
import 'package:sherlock/util/board_solver.dart';
import 'package:sherlock/util/clue_generator.dart';

@Injectable()
class GameService {
  PuzzleDescription _currentPuzzle;
  PuzzleDescription get currentPuzzle => _currentPuzzle;

  GameField _currentField;

  int difficulty = 2;

  GameField get currentField => _currentField;
  List<List<GameLine>> turns = [];

  GameField get currentBoard => currentPuzzle.board;
  List<GenericClue> get currentRuleSet => currentPuzzle.ruleSet;

  List<List<GameLine>> _undoPositions = [];

  void initRandomConfiguration() {
    _currentPuzzle = _generateRuleSet(new GameField.initial(), 0);
    _currentField = _currentPuzzle.board;
    turns = [];

//    print("Clues total: ${currentRuleSet.length}");
//    print("Opened cells total: ${currentBoard.openedCells}");
  }

  void resolveCell(int line, int position, int item) {
    _currentField.getCell(line, position).currentState.resolveWith(item);
    _currentField.optimizeBoard();
  }

  void removeItem(int line, int position, int item) {
    _currentField.getCell(line, position).currentState.removeItem(item);
    _currentField.optimizeBoard();
  }

  void addPositionToUndo() {
    _undoPositions.add(_currentField.lines.map((GameLine line)=> line.clone()).toList());
  }

  void undo() {
    if (_undoPositions.isNotEmpty) {
      _currentField = new GameField.fromArray(_undoPositions.removeLast());
    }
  }

  bool undoToLastKnownGood() {
    bool undoed = false;
    while (_positionIsNotGood()) {
      undo();
      undoed = true;
    }
    return undoed;
  }

  bool _positionIsNotGood() {
    for (int i=0; i<6; i++) {
      for (int j = 0; j < 6; j++) {
        GameCell cell = _currentField.getCell(i, j);
        if (!cell.currentState.hasPossibleItem(cell.correctItem)) {
          return true;
        }
      }
    }
    return false;
  }

  PuzzleDescription _generateRuleSet(GameField field, int id) {
    List<GenericClue> clues;
    GameField fieldClone;
    for (int i=0; i< difficulty*3; i++) {
      _openRandomCell(field);
    }
    while(true) {
      clues = ClueGenerator.generateClueSet(field, difficulty);
      fieldClone = field.clone();
      int opened = _checkOpenedCells(fieldClone, clues);
      if (opened <= 2) {
        clues = _shrinkClues(fieldClone, clues);
        if (clues != null) {
          _shuffleClues(clues);
          break;
        }
      }
    }

    GameField result = fieldClone.clone();
    BoardSolver.trySolve(fieldClone, clues);
    if (fieldClone.getNotResolvedCellCount() != 0) {
      throw("Impossible. Shit happens");
    }
    //clues.sort((GenericClue a, GenericClue b) => a.sortOrder.compareTo(b.sortOrder));

    PuzzleDescription descr = new PuzzleDescription(id, result, clues);
    _undoPositions.clear();
    return descr;
  }

  void _shuffleClues(List<GenericClue> clues) {
    Random random = new Random();
    for (var i = 0; i < clues.length; ++i) {
      int position = random.nextInt(clues.length);
      GenericClue temp = clues[i];
      clues[i] = clues[position];
      clues[position] = temp;
    }
  }

  List<GenericClue> _shrinkClues(GameField field, List<GenericClue> clues) {
    for (var i = clues.length-1; i>=0; i--) {
      GameField fieldClone = field.clone();
      List<GenericClue> cluesClone = clues.toList();
      cluesClone.removeAt(i);
      BoardSolver.trySolve(fieldClone, cluesClone);
      if (fieldClone.getNotResolvedCellCount() == 0) {
        List<GenericClue> next = _shrinkClues(field, cluesClone);
        return next?? cluesClone;
      }
    }
    return null;
  }

  int _checkOpenedCells(GameField field, List<GenericClue> clues) {
    int opened = 0;
    while (true) {
      GameField current = field.clone();
      BoardSolver.trySolve(current, clues);
      if (current.getNotResolvedCellCount() > 0) {
        opened++;
        if (opened == 3) {
          //Too much initially opened, giving up
          return opened;
        }
        //Opening one cell and repeat
        _openRandomCell(field);
      }
      else {
        //Puzzle solved, rule set is acceptable for this board
        break;
      }
    }
    return opened;
  }

  void _openRandomCell(GameField field) {
    Random random = new Random();
    int line;
    int position;
    do {
      line = random.nextInt(6);
      position = random.nextInt(6);
    } while (field.getCell(line, position).currentState.isResolved);

    field.getCell(line, position).currentState.resolveWith(field.getCell(line, position).correctItem);
    field.optimizeBoard();
  }
}