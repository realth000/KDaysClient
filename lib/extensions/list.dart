/// [List] 类型的扩展
extension ListExtension<T> on List<T> {
  /// 在当前[List]的每两个元素中间插入一个[item]
  List<T> insertBetween(T item) {
    if (length < 1) {
      return this;
    }

    return skip(1).fold([first], (acc, x) {
      acc
        ..add(item)
        ..add(x);
      return acc;
    }).toList();
  }
}
