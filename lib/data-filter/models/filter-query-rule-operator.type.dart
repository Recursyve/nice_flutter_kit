class FilterQueryRuleOperatorType {
  final String _value;

  const FilterQueryRuleOperatorType._internal(this._value);

  String toString() => _value;

  static const Equal = const FilterQueryRuleOperatorType._internal("equal");
  static const NotEqual = const FilterQueryRuleOperatorType._internal("not_equal");
  static const In = const FilterQueryRuleOperatorType._internal("in");
  static const NotIn = const FilterQueryRuleOperatorType._internal("not_in");
  static const Less = const FilterQueryRuleOperatorType._internal("less");
  static const LessOrEqual = const FilterQueryRuleOperatorType._internal("less_or_equal");
  static const Greater = const FilterQueryRuleOperatorType._internal("greater");
  static const GreaterOrEqual = const FilterQueryRuleOperatorType._internal("greater_or_equal");
  static const Between = const FilterQueryRuleOperatorType._internal("between");
  static const NotBetween = const FilterQueryRuleOperatorType._internal("not_between");
  static const IsNull = const FilterQueryRuleOperatorType._internal("is_null");
  static const IsNotNull = const FilterQueryRuleOperatorType._internal("is_not_null");
  static const BeginsWith = const FilterQueryRuleOperatorType._internal("begins_with");
  static const NotBeginsWith = const FilterQueryRuleOperatorType._internal("not_begins_with");
  static const EndsWith = const FilterQueryRuleOperatorType._internal("ends_with");
  static const NotEndsWith = const FilterQueryRuleOperatorType._internal("not_ends_with");
  static const Contains = const FilterQueryRuleOperatorType._internal("contains");
  static const NotContains = const FilterQueryRuleOperatorType._internal("not_contains");
  static const IsEmpty = const FilterQueryRuleOperatorType._internal("is_empty");
  static const IsNotEmpty = const FilterQueryRuleOperatorType._internal("is_not_empty");
}
