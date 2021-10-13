import 'package:nice_flutter_kit/data-filter/models/filter-order.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-page.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-query.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-search.model.dart';

class NiceFilterModel {
  NiceFilterOrderModel? order;
  NiceFilterPageModel? page;
  NiceFilterQueryModel? query;
  NiceFilterSearchModel? search;

  NiceFilterModel({this.order, this.page, this.query, this.search});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "order": order?.toJson(),
        "page": page?.toJson(),
        "query": query?.toJson(),
        "search": search?.toJson()
      };
}
