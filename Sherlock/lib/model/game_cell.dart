import 'package:untitled/model/game_state.dart';
import 'package:untitled/util/cloneable.dart';

class GameCell implements Cloneable {
  final int _correctItem;
  GameState _currentState;
  GameState _lastKnownGoodState;

  GameState get currentState => _currentState;
  int get correctItem => _correctItem;

  @override
  GameCell clone() {
    return new GameCell.fromState(_correctItem, currentState, _lastKnownGoodState);
  }

  GameCell.initial(this._correctItem) {
    _currentState = new GameState.initial();
    _lastKnownGoodState = _currentState.clone();
  }

  GameCell.fromState(this._correctItem, GameState currentState, GameState lastKnownGoodState) {
    _currentState = currentState.clone();
    _lastKnownGoodState = lastKnownGoodState.clone();
  }
}