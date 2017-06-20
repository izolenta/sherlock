import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:sherlock/services/game_service.dart';
import 'package:sherlock/services/sound_service.dart';

@Component(
    selector: 'unresolved-board-cell',
    styleUrls: const ['unresolved_board_cell_component.css'],
    templateUrl: 'unresolved_board_cell_component.html',
    directives: const [NgFor, materialDirectives]
)
class UnresolvedBoardCellComponent {

  final List<int> numbers = [0, 1, 2];
  final List<int> rows = [1, 2];
  final GameService _gameService;
  final SoundService _soundService;

  DateTime time;

  bool get isTabletMode => Uri.base.queryParameters['tablet'] != null;

  @Input() int line;
  @Input() int position;

  UnresolvedBoardCellComponent(this._gameService, this._soundService);

  String getClass(int index) {
    if (_gameService.currentField.getCell(line, position).currentState.hasPossibleItem(index)) {
      return "s$line$index";
    }
    else return "empty";
  }

  void onPress(MouseEvent event) {
    time = new DateTime.now();
  }

  void onClick(int item, MouseEvent event) {
    if (_gameService.currentField.getCell(line, position).currentState.hasPossibleItem(item)) {
      _gameService.addPositionToUndo();
      if (!isTabletMode) {
        if (event.button == 0) {
          _gameService.resolveCell(line, position, item);
        }
        else if (event.button == 2) {
          _gameService.removeItem(line, position, item);
        }
      }
      else if (event.button == 0) {
        Duration duration = time != null? new DateTime.now().difference(time) : 0;
        if (duration.inMilliseconds > 500) {
          _gameService.resolveCell(line, position, item);
        }
        else {
          _gameService.removeItem(line, position, item);
        }
      }
      if (_gameService.isGameWon()) {
        _soundService.playSuccess();
      }
      else {
        _soundService.playWaterdrop();
      }
    }
  }
}
