enum NiceFilterOrderDirections {
  Asc("asc"),
  Desc("desc");

  final String value;

  const NiceFilterOrderDirections(this.value);

  String toString() => value;
}
