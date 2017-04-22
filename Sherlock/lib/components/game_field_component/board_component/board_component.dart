import 'package:angular2/angular2.dart';
import 'package:sherlock/components/game_field_component/board_cell_component/board_cell_component.dart';
import 'package:sherlock/model/game_field.dart';
import 'package:sherlock/services/game_service.dart';

@Component(
    selector: 'board',
    styleUrls: const ['board_component.css'],
    templateUrl: 'board_component.html',
    directives: const [NgFor, BoardCellComponent]
)
class BoardComponent {
  final GameService _gameService;

  GameField get field => _gameService.currentField;

  BoardComponent(this._gameService);
}
