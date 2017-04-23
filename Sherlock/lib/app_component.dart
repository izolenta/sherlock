// Copyright (c) 2017, alea. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';
import 'package:sherlock/components/game_field_component/game_field_component.dart';
import 'package:sherlock/services/game_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, GameFieldComponent],
  providers: const [materialProviders, GameService],
)
class AppComponent implements OnInit {

  final GameService _gameService;

  AppComponent(this._gameService);

  @override
  void ngOnInit() {
    _gameService.initRandomConfiguration();
  }
}
