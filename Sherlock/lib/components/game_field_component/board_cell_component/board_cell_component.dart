import 'package:angular2/angular2.dart';
import 'package:sherlock/components/game_field_component/board_cell_component/resolved_board_cell_component/resolved_board_cell_component.dart';
import 'package:sherlock/components/game_field_component/board_cell_component/unresolved_board_cell_component/unresolved_board_cell_component.dart';
import 'package:sherlock/model/game_cell.dart';

@Component(
    selector: 'board-cell',
    styleUrls: const ['board_cell_component.css'],
    templateUrl: 'board_cell_component.html',
    directives: const [NgIf, ResolvedBoardCellComponent, UnresolvedBoardCellComponent]
)
class BoardCellComponent {
  @Input() GameCell cellData;
  @Input() int line;
  @Input() int position;

  bool get isResolved => cellData?.currentState?.isResolved?? false;
  int get resolvedValue => cellData?.currentState?.getResolvedValue()?? 0;

  String getResolvedClass() {
    return "s${line}${resolvedValue}";
  }
}