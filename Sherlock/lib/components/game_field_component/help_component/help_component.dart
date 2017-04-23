import 'package:angular2/angular2.dart';

@Component(
    selector: 'help',
    styleUrls: const ['help_component.css'],
    templateUrl: 'help_component.html',
    directives: const []
)
class HelpComponent {
  @Output("help-closed") EventEmitter helpClosedEmitter = new EventEmitter(false);

  void closeHelp() {
    helpClosedEmitter.emit(null);
  }
}
