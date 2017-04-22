import 'package:angular2/angular2.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:sherlock/components/game_field_component/board_component/board_component.dart';

@Component(
    selector: 'game-field',
    styleUrls: const ['game_field_component.css'],
    templateUrl: 'game_field_component.html',
    directives: const [materialDirectives, BoardComponent]
)
class GameFieldComponent {

}