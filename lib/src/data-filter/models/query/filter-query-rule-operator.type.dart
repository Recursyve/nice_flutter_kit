enum NiceFilterQueryRuleOperators {
  Equal("equal"),
  NotEqual("not_equal"),
  In("in"),
  NotIn("not_in"),
  Less("less"),
  LessOrEqual("less_or_equal"),
  Greater("greater"),
  GreaterOrEqual("greater_or_equal"),
  Between("between"),
  NotBetween("not_between"),
  IsNull("is_null"),
  IsNotNull("is_not_null"),
  BeginsWith("begins_with"),
  NotBeginsWith("not_begins_with"),
  EndsWith("ends_with"),
  NotEndsWith("not_ends_with"),
  Contains("contains"),
  NotContains("not_contains"),
  IsEmpty("is_empty"),
  IsNotEmpty("is_not_empty");

  final String value;

  const NiceFilterQueryRuleOperators(this.value);

  @override
  String toString() => value;
}
