import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

@immutable
class NiceBaseListConfig<D> {
  final NiceDataFilterApi<D> filterApi;
  final NiceFilterOrderModel defaultOrder;
  final int itemsPerPage;

  const NiceBaseListConfig({
    required this.filterApi,
    this.defaultOrder = const NiceFilterOrderModel(
      column: "createdAt",
      direction: NiceFilterOrderDirectionType.Asc,
    ),
    this.itemsPerPage = 20,
  });
}
