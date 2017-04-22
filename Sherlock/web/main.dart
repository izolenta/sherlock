// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:angular2/platform/browser.dart';

//import 'package:untitled/app_component.dart';
import 'package:untitled/model/clues/clue_item.dart';
import 'package:untitled/model/clues/generic_clue.dart';
import 'package:untitled/model/clues/three_adjacent_clue.dart';
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

  ThreeAdjacentClue clue1 = new ThreeAdjacentClue.generate(field);
  ThreeAdjacentClue clue2 = new ThreeAdjacentClue.generate(field);

  clue1.first = new ClueItem(11, 22);
  clue1.second = new ClueItem(11, 33);;
  clue1.third = new ClueItem(11, 44);;
  clue2.first = new ClueItem(11, 22);
  clue2.second = new ClueItem(11, 33);;
  clue2.third = new ClueItem(11, 44);;

  print (clue1 == clue2);
}
