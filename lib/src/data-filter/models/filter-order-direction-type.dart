enum NiceFilterOrderDirections {
  Asc("asc"),
  Desc("desc");

  final String value;

  const NiceFilterOrderDirections(this.value);

  @override
  String toString() => value;
}
