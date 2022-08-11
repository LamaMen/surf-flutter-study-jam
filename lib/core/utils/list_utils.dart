extension ListUtils<T> on List<T> {
  List<T> reversedByCondition(bool isReversed) {
    return isReversed ? reversed.toList() : this;
  }
}
