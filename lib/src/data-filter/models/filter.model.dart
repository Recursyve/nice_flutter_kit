import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterModel {
  final NiceFilterOrderModel? order;
  final NiceFilterPageModel? page;
  final NiceFilterQueryModel? query;
  final NiceFilterSearchModel? search;

  const NiceFilterModel({this.order, this.page, this.query, this.search});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "order": order?.toJson(),
        "page": page?.toJson(),
        "query": query?.toJson(),
        "search": search?.toJson()
      };
}
