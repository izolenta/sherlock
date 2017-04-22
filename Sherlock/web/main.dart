// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/platform/browser.dart';

import 'package:untitled/app_component.dart';
import 'package:untitled/model/game_field.dart';
import 'package:untitled/services/game_service.dart';

Future main() async {
  await new Future.delayed(new Duration(seconds: 1));
  bootstrap(AppComponent);
//  generateBoard();
}

void generateBoard() {
  GameField field = new GameField.initial();
  field.printCorrectState();
  print('-------------------------');
  GameService service = new GameService();
  service.initRandomConfiguration();
}