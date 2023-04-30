import "package:equatable/equatable.dart";

class NiceFilterOrderDirectionType extends Equatable {
  final String _value;

  const NiceFilterOrderDirectionType._internal(this._value);

  @override
  String toString() => _value;

  static const Asc = NiceFilterOrderDirectionType._internal("asc");
  static const Desc = NiceFilterOrderDirectionType._internal("desc");

  @override
  List<Object> get props => [_value];
}
