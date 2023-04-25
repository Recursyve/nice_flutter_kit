import "package:equatable/equatable.dart";

class NiceFilterQueryRuleOperatorType extends Equatable {
  final String _value;

  const NiceFilterQueryRuleOperatorType._internal(this._value);

  @override
  String toString() => _value;

  static const Equal = NiceFilterQueryRuleOperatorType._internal("equal");
  static const NotEqual = NiceFilterQueryRuleOperatorType._internal("not_equal");
  static const In = NiceFilterQueryRuleOperatorType._internal("in");
  static const NotIn = NiceFilterQueryRuleOperatorType._internal("not_in");
  static const Less = NiceFilterQueryRuleOperatorType._internal("less");
  static const LessOrEqual = NiceFilterQueryRuleOperatorType._internal("less_or_equal");
  static const Greater = NiceFilterQueryRuleOperatorType._internal("greater");
  static const GreaterOrEqual = NiceFilterQueryRuleOperatorType._internal("greater_or_equal");
  static const Between = NiceFilterQueryRuleOperatorType._internal("between");
  static const NotBetween = NiceFilterQueryRuleOperatorType._internal("not_between");
  static const IsNull = NiceFilterQueryRuleOperatorType._internal("is_null");
  static const IsNotNull = NiceFilterQueryRuleOperatorType._internal("is_not_null");
  static const BeginsWith = NiceFilterQueryRuleOperatorType._internal("begins_with");
  static const NotBeginsWith = NiceFilterQueryRuleOperatorType._internal("not_begins_with");
  static const EndsWith = NiceFilterQueryRuleOperatorType._internal("ends_with");
  static const NotEndsWith = NiceFilterQueryRuleOperatorType._internal("not_ends_with");
  static const Contains = NiceFilterQueryRuleOperatorType._internal("contains");
  static const NotContains = NiceFilterQueryRuleOperatorType._internal("not_contains");
  static const IsEmpty = NiceFilterQueryRuleOperatorType._internal("is_empty");
  static const IsNotEmpty = NiceFilterQueryRuleOperatorType._internal("is_not_empty");

  @override
  List<Object> get props => [_value];
}
