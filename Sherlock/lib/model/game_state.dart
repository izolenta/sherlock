import 'dart:math';
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

  void removeItem(int item) {
    _checkItem(item);
    state = state - pow(2, item);
  }

  bool hasPossibleItem(int item) {
    return _state & pow(2, item) != 0;
  }

  void _checkItem(int item) {
    if (item < 0 || item > 5) {
      throw "Wrong item to resolve";
    }
    if (!hasPossibleItem(item)) {
      throw "this cell does not contain the item!";
    }
  }
}