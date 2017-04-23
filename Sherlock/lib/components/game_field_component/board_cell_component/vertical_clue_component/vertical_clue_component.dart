import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/clues/two_in_same_column_clue.dart';
import 'package:sherlock/model/clues/two_not_in_same_column_clue.dart';

@Component(
  selector: 'vertical-clue',
  styleUrls: const ['vertical_clue_component.css'],
  templateUrl: 'vertical_clue_component.html',
  directives: const [NgIf, materialDirectives],
)
class VerticalClueComponent implements OnChanges {
  @Input() GenericClue clue;

  String _formattedDescription = "";
  String get formattedDescription => _formattedDescription;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    _formatDescription();
  }

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

  void _formatDescription() {
    String divFirst = '<div class="sprite micro inline ' + getFirstSpriteClass() +
        '"></div>';
    String divSecond = '<div class="sprite micro inline ' + getSecondSpriteClass() +
        '"></div>';
    _formattedDescription = clue.description.replaceAll("{0}", divFirst);
    _formattedDescription = _formattedDescription.replaceAll("{1}", divSecond);
  }
}