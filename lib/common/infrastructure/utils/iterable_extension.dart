extension IterableExtension<T> on Iterable<T> {
  List<T> sorted(Comparator<T> compare) => [...this]..sort(compare);
}
