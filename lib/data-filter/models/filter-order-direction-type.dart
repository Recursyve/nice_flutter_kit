import 'package:equatable/equatable.dart';

class NiceFilterOrderDirectionType extends Equatable {
  final String _value;

  const NiceFilterOrderDirectionType._internal(this._value);

  String toString() => _value;

  static const Asc = const NiceFilterOrderDirectionType._internal("asc");
  static const Desc = const NiceFilterOrderDirectionType._internal("desc");

  @override
  List<Object> get props => [_value];
}
