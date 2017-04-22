// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:angular2/platform/browser.dart';

//import 'package:untitled/app_component.dart';
import 'package:untitled/model/game_field.dart';

void main() {
//  bootstrap(AppComponent);
  generateBoard();
}

void generateBoard() {
  GameField field = new GameField.initial();
  for (var line in field.lines) {
    for (var cell in line.cells) {
      print([cell.currentState.state, cell.correctItem]);
    }
  }
}
