class FilterOrderDirectionType {
  final String _value;

  const FilterOrderDirectionType._internal(this._value);

  String toString() => _value;

  static const Asc = const FilterOrderDirectionType._internal("asc");
  static const Desc = const FilterOrderDirectionType._internal("desc");
}
