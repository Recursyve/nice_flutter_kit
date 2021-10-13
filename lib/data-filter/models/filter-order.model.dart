import 'package:nice_flutter_kit/data-filter/models/filter-order-direction-type.dart';

class NiceFilterOrderModel {
  final String column;
  final NiceFilterOrderDirectionType direction;

  NiceFilterOrderModel({required this.column, required this.direction});

  Map<String, dynamic> toJson() => <String, dynamic>{"column": column, "direction": direction.toString()};
}
