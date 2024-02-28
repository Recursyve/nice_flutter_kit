import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterOrderModel extends Equatable {
  final String column;
  final NiceFilterOrderDirections direction;

  const NiceFilterOrderModel({
    required this.column,
    required this.direction,
  });

  Json toJson() => {
        "column": column,
        "direction": direction.value,
      };

  @override
  List<Object> get props => [column, direction];
}
