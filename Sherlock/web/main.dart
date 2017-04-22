// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/platform/browser.dart';

import 'package:sherlock/app_component.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/services/game_service.dart';

Future main() async {
  await new Future.delayed(new Duration(seconds: 3));
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