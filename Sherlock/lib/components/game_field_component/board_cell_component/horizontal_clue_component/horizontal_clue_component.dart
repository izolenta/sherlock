import 'package:angular2/angular2.dart';
import 'package:sherlock/model/clues/clue_item.dart';
import 'package:sherlock/model/clues/generic_clue.dart';
import 'package:sherlock/model/clues/one_should_be_before_other_clue.dart';
import 'package:sherlock/model/clues/three_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_not_adjacent_clue.dart';
import 'package:sherlock/model/clues/two_with_not_third_at_center_clue.dart';

@Component(
    selector: 'horizontal-clue',
    styleUrls: const ['horizontal_clue_component.css'],
    templateUrl: 'horizontal_clue_component.html',
    directives: const [NgIf]
)
class HorizontalClueComponent {
  @Input() GenericClue clue;
  @Input() bool isUsed = false;

  ClueItem get firstItem {
    if (clue is ThreeAdjacentClue) {
      return (clue as ThreeAdjacentClue).first;
    }
    if (clue is TwoAdjacentClue) {
      return (clue as TwoAdjacentClue).first;
    }
    if (clue is TwoNotAdjacentClue) {
      return (clue as TwoNotAdjacentClue).first;
    }
    if (clue is OneShouldBeBeforeOtherClue) {
      return (clue as OneShouldBeBeforeOtherClue).first;
    }
    if (clue is TwoWithNoThirdAtCenterClue) {
      return (clue as TwoWithNoThirdAtCenterClue).first;
    }
    return null;
  }

  ClueItem get secondItem {
    if (clue is ThreeAdjacentClue) {
      return (clue as ThreeAdjacentClue).second;
    }
    if (clue is TwoAdjacentClue) {
      return null;
    }
    if (clue is TwoNotAdjacentClue) {
      return (clue as TwoNotAdjacentClue).first;
    }
    if (clue is OneShouldBeBeforeOtherClue) {
      return (clue as OneShouldBeBeforeOtherClue).second;
    }
    if (clue is TwoWithNoThirdAtCenterClue) {
      return (clue as TwoWithNoThirdAtCenterClue).second;
    }
    return null;
  }

  ClueItem get thirdItem {
    if (clue is ThreeAdjacentClue) {
      return (clue as ThreeAdjacentClue).third;
    }
    if (clue is TwoAdjacentClue) {
      return (clue as TwoAdjacentClue).second;
    }
    if (clue is TwoNotAdjacentClue) {
      return (clue as TwoNotAdjacentClue).second;
    }
    if (clue is OneShouldBeBeforeOtherClue) {
      return null;
    }
    if (clue is TwoWithNoThirdAtCenterClue) {
      return (clue as TwoWithNoThirdAtCenterClue).third;
    }
    return null;
  }

  String getFirstSpriteClass() {
    return firstItem != null
        ? "s${firstItem.line}${firstItem.number}"
        : "empty";
  }

  String getSecondSpriteClass() {
    return secondItem != null
        ? "s${secondItem.line}${secondItem.number}"
        : "empty";
  }

  String getThirdSpriteClass() {
    return thirdItem != null
        ? "s${thirdItem.line}${thirdItem.number}"
        : "empty";
  }

  bool needToDisplayCross() {
    return clue is TwoWithNoThirdAtCenterClue || clue is TwoNotAdjacentClue;
  }

  bool needToDisplayArrows3() {
    return clue is ThreeAdjacentClue || clue is TwoWithNoThirdAtCenterClue;
  }

  bool needToDisplayArrows2() {
    return clue is TwoAdjacentClue;
  }

  bool needToDisplayDots() {
    return clue is OneShouldBeBeforeOtherClue;
  }
}