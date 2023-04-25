import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterOrderModel extends Equatable {
  final String column;
  final NiceFilterOrderDirectionType direction;

  const NiceFilterOrderModel({required this.column, required this.direction});

  Map<String, dynamic> toJson() => <String, dynamic>{"column": column, "direction": direction.toString()};

  @override
  List<Object> get props => [column, direction];
}
