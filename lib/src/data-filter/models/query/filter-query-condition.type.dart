enum NiceFilterQueryConditionType {
  And("and"),
  Or("or");

  final String value;

  const NiceFilterQueryConditionType(this.value);

  @override
  String toString() => value;
}
