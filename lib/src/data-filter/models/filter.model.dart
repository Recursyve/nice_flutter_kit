import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterModel {
  final List<NiceFilterOrderModel>? order;
  final NiceFilterPageModel page;
  final NiceFilterQueryModel? query;
  final NiceFilterSearchModel? search;

  const NiceFilterModel({
    this.order,
    required this.page,
    this.query,
    this.search,
  });

  Json toJson() => {
        if (order != null) "order": [...order!.map((order) => order.toJson())],
        "page": page.toJson(),
        if (query != null) "query": query!.toJson(),
        if (search != null) "search": search!.toJson(),
      };
}
