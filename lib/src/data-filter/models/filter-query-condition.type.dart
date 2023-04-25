import "package:equatable/equatable.dart";

class NiceFilterQueryConditionType extends Equatable {
  final String _value;

  const NiceFilterQueryConditionType._internal(this._value);

  @override
  String toString() => _value;

  static const And = NiceFilterQueryConditionType._internal("and");
  static const Or = NiceFilterQueryConditionType._internal("or");

  @override
  List<Object> get props => [_value];
}
