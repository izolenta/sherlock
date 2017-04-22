import 'dart:math';
import 'package:angular2/angular2.dart';
import 'package:sherlock/components/game_field_component/board_cell_component/resolved_board_cell_component/resolved_board_cell_component.dart';

@Component(
    selector: 'board-cell',
    styleUrls: const ['board_cell_component.css'],
    templateUrl: 'board_cell_component.html',
    directives: const [ResolvedBoardCellComponent]
)
class BoardCellComponent {
  String getResolvedClass() {
    Random rand = new Random();
    return "s${rand.nextInt(6)}${rand.nextInt(6)}";
  }
}