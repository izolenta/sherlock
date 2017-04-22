import 'package:untitled/util/cloneable.dart';

class GameState implements Cloneable {

  static const int initialState = 63;

  int _state;

  int get state => _state;
  void set state(int value) {
    _state = value;
  }

  bool get isResolved => state & (state-1) == 0;

  GameState clone() {
    return new GameState.fromState(state);
  }

  GameState.initial() {
    resetToInitialState();
  }

  GameState.fromState(int currentState) {
    state = currentState;
  }

  void resetToInitialState() {
    state = GameState.initialState;
  }
}