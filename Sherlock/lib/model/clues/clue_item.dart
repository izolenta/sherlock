class ClueItem {
  final int line;
  final int number;

  ClueItem(this.line, this.number);

  bool equalsTo(ClueItem item) {
    return item.line == line && item.number == number;
  }
}