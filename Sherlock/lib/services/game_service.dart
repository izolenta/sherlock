import 'package:untitled/model/game_field.dart';
import 'package:untitled/model/game_line.dart';
import 'package:untitled/model/puzzle_description.dart';

class GameService {
  PuzzleDescription _currentPuzzle;
  PuzzleDescription get currentPuzzle => _currentPuzzle;

  GameField _currentField;

  GameField get currentField => _currentField;
  List<List<GameLine>> turns = [];

}