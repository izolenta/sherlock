import 'package:angular2/angular2.dart';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/clues/two_in_same_column_clue.dart';
import 'package:sherlock/model/clues/two_not_in_same_column_clue.dart';

@Component(
  selector: 'vertical-clue',
  styleUrls: const ['vertical_clue_component.css'],
  templateUrl: 'vertical_clue_component.html',
  directives: const [NgIf],
)
class VerticalClueComponent {
  @Input() GenericClue clue;

  ClueItem get firstItem {
    if (clue is TwoInSameColumnClue) {
      return (clue as TwoInSameColumnClue).first;
    }
    if (clue is TwoNotInSameColumnClue) {
      return (clue as TwoNotInSameColumnClue).first;
    }
    return null;
  }

  ClueItem get secondItem {
    if (clue is TwoInSameColumnClue) {
      return (clue as TwoInSameColumnClue).second;
    }
    if (clue is TwoNotInSameColumnClue) {
      return (clue as TwoNotInSameColumnClue).second;
    }
    return null;
  }

  String getFirstSpriteClass() {
    return "s${firstItem.line}${firstItem.number}";
  }

  String getSecondSpriteClass() {
    return "s${secondItem.line}${secondItem.number}";
  }

  bool needToDisplayCross() {
    return clue is TwoNotInSameColumnClue;
  }
}