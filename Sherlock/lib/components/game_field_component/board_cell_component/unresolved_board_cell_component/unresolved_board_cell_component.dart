import 'package:angular2/angular2.dart';
import 'package:sherlock/services/game_service.dart';

@Component(
    selector: 'unresolved-board-cell',
    styleUrls: const ['unresolved_board_cell_component.css'],
    templateUrl: 'unresolved_board_cell_component.html',
    directives: const [NgFor]
)
class UnresolvedBoardCellComponent {

  final List<int> numbers = [0, 1, 2];
  final List<int> rows = [1, 2];
  final GameService _gameService;

  @Input() int line;
  @Input() int position;

  UnresolvedBoardCellComponent(this._gameService);

  String getClass(int index) {
    if (_gameService.currentField.getCell(line, position).currentState.hasPossibleItem(index)) {
      return "s$line$index";
    }
    else return "empty";
  }
}
