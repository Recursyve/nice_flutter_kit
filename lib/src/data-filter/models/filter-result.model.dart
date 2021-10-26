import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterResultModel<T> extends Equatable {
  NiceFilterResultPageModel? page;
  int? total;
  List<T>? values;

  NiceFilterResultModel({this.page, this.total, this.values});

  NiceFilterResultModel.fromJson(LinkedHashMap<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    page = NiceFilterResultPageModel.fromJson(json["page"]);
    total = json["total"];

    assert(
      NiceConfig.dataFilterConfig != null,
      "NiceDataFilter wasn't initialized, please provide NiceDataFilterConfig in main",
    );

    values = [
      for (final data in json["values"] ?? const [])
        NiceConfig.dataFilterConfig!.deserialize(
          data,
        ),
    ];
  }

  @override
  List<Object?> get props => [page, total, values];
}
