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

  bool isResolvedTo(int item) {
    return _state == pow(2, item);
  }

  void resolveWith(int item) {
    _checkItem(item);
    state = pow(2, item);
  }

  int getResolvedValue() {
    for (int i=0; i<6; i++) {
      if (_state & pow(2, i) != 0) {
        return i;
      }
    }
    throw "Bad state";
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