// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:angular2/platform/browser.dart';

//import 'package:untitled/app_component.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/game_field.dart';
import 'package:untitled/util/clue_generator.dart';

void main() {
//  bootstrap(AppComponent);
  generateBoard();
}

void generateBoard() {
  GameField field = new GameField.initial();
  field.printCorrectState();
  print('-------------------------');
  List<GenericClue> clues = ClueGenerator.generateClueSet(field);
}
