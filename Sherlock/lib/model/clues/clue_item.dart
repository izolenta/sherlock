class ClueItem {
  final int line;
  final int number;

  ClueItem(this.line, this.number);

  bool operator ==(item) {
    return item is ClueItem && item.line == line && item.number == number;
  }
}