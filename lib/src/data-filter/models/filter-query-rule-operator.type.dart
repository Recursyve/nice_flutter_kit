import 'package:equatable/equatable.dart';

class NiceFilterQueryRuleOperatorType extends Equatable {
  final String _value;

  const NiceFilterQueryRuleOperatorType._internal(this._value);

  String toString() => _value;

  static const Equal = const NiceFilterQueryRuleOperatorType._internal("equal");
  static const NotEqual = const NiceFilterQueryRuleOperatorType._internal("not_equal");
  static const In = const NiceFilterQueryRuleOperatorType._internal("in");
  static const NotIn = const NiceFilterQueryRuleOperatorType._internal("not_in");
  static const Less = const NiceFilterQueryRuleOperatorType._internal("less");
  static const LessOrEqual = const NiceFilterQueryRuleOperatorType._internal("less_or_equal");
  static const Greater = const NiceFilterQueryRuleOperatorType._internal("greater");
  static const GreaterOrEqual = const NiceFilterQueryRuleOperatorType._internal("greater_or_equal");
  static const Between = const NiceFilterQueryRuleOperatorType._internal("between");
  static const NotBetween = const NiceFilterQueryRuleOperatorType._internal("not_between");
  static const IsNull = const NiceFilterQueryRuleOperatorType._internal("is_null");
  static const IsNotNull = const NiceFilterQueryRuleOperatorType._internal("is_not_null");
  static const BeginsWith = const NiceFilterQueryRuleOperatorType._internal("begins_with");
  static const NotBeginsWith = const NiceFilterQueryRuleOperatorType._internal("not_begins_with");
  static const EndsWith = const NiceFilterQueryRuleOperatorType._internal("ends_with");
  static const NotEndsWith = const NiceFilterQueryRuleOperatorType._internal("not_ends_with");
  static const Contains = const NiceFilterQueryRuleOperatorType._internal("contains");
  static const NotContains = const NiceFilterQueryRuleOperatorType._internal("not_contains");
  static const IsEmpty = const NiceFilterQueryRuleOperatorType._internal("is_empty");
  static const IsNotEmpty = const NiceFilterQueryRuleOperatorType._internal("is_not_empty");

  @override
  List<Object> get props => [_value];
}
