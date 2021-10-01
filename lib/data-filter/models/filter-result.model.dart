import "dart:collection";

import 'package:nice_flutter_kit/data-filter/models/filter-result-page.model.dart';
import 'package:nice_flutter_kit/nice-flutter-kit-config.dart';

class FilterResultModel<T> {
  FilterResultPageModel? page;
  int? total;
  List<T>? values;

  FilterResultModel({this.page, this.total, this.values});

  FilterResultModel.fromJson(LinkedHashMap<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    page = FilterResultPageModel.fromJson(json["page"]);
    total = json["total"];

    if (NiceFlutterKitConfig.dataFilterConfig == null) {
      throw Exception("Data filter config not defined.\nYou must define it in NiceFlutterKitConfig.");
    }

    values = [
      for (final data in json["values"] ?? const [])
        NiceFlutterKitConfig.dataFilterConfig!.deserialize(
          data,
        ),
    ];
  }
}
