// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:angular2/platform/browser.dart';

//import 'package:untitled/app_component.dart';
import 'dart:math';
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

  field.printCurrentState();

//  _openRandomCell(field);
//  _openRandomCell(field);
//  _openRandomCell(field);
  while(true) {
    bool isApplied = false;
    for (GenericClue clue in clues) {
      if (clue.applyToField(field)) {
        isApplied = true;
        print("Clue applied: "+clue.toString());
        field.optimizeBoard();
        field.printCurrentState();
      }
    }
    if (isApplied) {
      if (field.isResolved) {
        print("RESOLVED!!!");
        field.printCorrectState();
        break;
      }
      else {
        print("Continuing...");
      }
    }
    else
    {
      print("Shit happens, no solution there.");
      break;
    }
  }
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