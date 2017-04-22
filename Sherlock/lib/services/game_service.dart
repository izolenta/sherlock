import 'dart:math';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';
import 'package:untitled/model/game_line.dart';
import 'package:untitled/model/puzzle_description.dart';
import 'package:untitled/util/board_solver.dart';
import 'package:untitled/util/clue_generator.dart';

class GameService {
  PuzzleDescription _currentPuzzle;
  PuzzleDescription get currentPuzzle => _currentPuzzle;

  GameField _currentField;

  GameField get currentField => _currentField;
  List<List<GameLine>> turns = [];

  GameField get currentBoard => currentPuzzle.board;
  List<GenericClue> get currentRuleSet => currentPuzzle.ruleSet;

  void initRandomConfiguration() {
    _currentPuzzle = _generateRuleSet(new GameField.initial(), 0);
    _currentField = _currentPuzzle.board;
    turns = [];
  }

  PuzzleDescription _generateRuleSet(GameField field, int id) {
    List<GenericClue> clues;
    GameField fieldClone;
//    _openRandomCell(field);
//    _openRandomCell(field);
    while(true) {
      clues = ClueGenerator.generateClueSet(field);
      fieldClone = field.clone();
      int opened = _checkOpenedCells(fieldClone, clues);
      if (opened <= 2 && clues != null) {
        break;
      }
    }

    GameField result = fieldClone.clone();
    BoardSolver.trySolve(fieldClone, clues);
    if (fieldClone.getNotResolvedCellCount() != 0) {
      throw("Impossible. Shit happens");
    }
    //clues.sort((GenericClue a, GenericClue b) => a.sortOrder.compareTo(b.sortOrder));

    PuzzleDescription descr = new PuzzleDescription(id, result, clues);
    return descr;
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