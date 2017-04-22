@TestOn("vm")
library sherlock.tests;

import 'dart:math';
import 'package:test/test.dart';
import 'package:untitled/model/game_cell.dart';
import 'package:untitled/model/game_line.dart';

void initTest() {
  group("board tests", () {
    setUp(() {
    });
    tearDown(() {
    });
    test("check optimizeLine after direct resolution", () {
      Random rand = new Random();
      for (int i=0; i< 50; i++) {
        GameLine line = new GameLine.initial();
        int cellNumber = rand.nextInt(6);
        GameCell cell = line.cells[cellNumber];
        int correctItem = cell.correctItem;
        cell.currentState.resolveWith(correctItem);
        line.optimizeLine();
        for (int i=0; i< 6; i++) {
          if (i == cellNumber) {
            expect(line.cells[i].currentState.isResolvedTo(correctItem), true);
          }
          else {
            expect(line.cells[i].currentState.hasPossibleItem(correctItem), false);
          }
        }
      }
    });
    test("check optimizeLine after indirect resolution", () {
      Random rand = new Random();
      for (int i=0; i< 50; i++) {
        GameLine line = new GameLine.initial();
        int cellNumber = rand.nextInt(6);
        GameCell cell = line.cells[cellNumber];
        int correctItem = cell.correctItem;
        for (int i=0; i<6; i++) {
          if (i != correctItem) {
            cell.currentState.removeItem(i);
            line.optimizeLine();
          }
        }
        for (int i=0; i< 6; i++) {
          if (i == cellNumber) {
            expect(line.cells[i].currentState.isResolvedTo(correctItem), true);
          }
          else {
            expect(line.cells[i].currentState.hasPossibleItem(correctItem), false);
          }
        }
      }
    });
  });
}

void main() {
  initTest();
}