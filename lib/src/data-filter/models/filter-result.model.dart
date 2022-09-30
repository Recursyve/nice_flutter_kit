import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterResultModel<T> extends Equatable {
  final NiceFilterResultPageModel page;
  final int total;
  final List<T> values;

  int? get nextPage => page.number * page.size + values.length < total ? page.number + 1 : null;

  const NiceFilterResultModel({
    required this.page,
    required this.total,
    required this.values,
  });

  NiceFilterResultModel.fromJson(Json json)
      : assert(
          NiceConfig.dataFilterConfig != null,
          "NiceDataFilter wasn't initialized, please provide a NiceDataFilterConfig.",
        ),
        page = NiceFilterResultPageModel.fromJson(json["page"]),
        total = json["total"],
        values = [for (final value in json["values"]) NiceConfig.dataFilterConfig!.deserialize(value)];

  NiceFilterResultModel<T> copyWith({
    NiceFilterResultPageModel? page,
    int? total,
    List<T>? values,
  }) {
    return NiceFilterResultModel(
      page: page ?? this.page,
      total: total ?? this.total,
      values: values ?? this.values,
    );
  }

  @override
  List<Object> get props => [page, total, values];
}
