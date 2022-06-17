import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

@immutable
class WorstBaseListConfig<D> {
  final NiceDataFilterApi<D> filterApi;
  final NiceFilterOrderModel defaultOrder;
  final int itemsPerPage;

  const WorstBaseListConfig({
    required this.filterApi,
    this.defaultOrder: const NiceFilterOrderModel(
      column: "createdAt",
      direction: NiceFilterOrderDirections.Asc,
    ),
    this.itemsPerPage: 20,
  });
}
