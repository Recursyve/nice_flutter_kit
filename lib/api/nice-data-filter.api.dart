import 'package:dio/dio.dart';
import 'package:nice_flutter_kit/api/api.dart';
import 'package:nice_flutter_kit/data-filter/data-filter.dart';
import 'package:nice_flutter_kit/nice-flutter-kit-config.dart';

abstract class NiceDataFilterApi<T> extends NiceBaseApi {
  final Dio dio;

  const NiceDataFilterApi(
    String path, {
    NiceFlutterKitApiConfig? overrideConfig,
    required this.dio,
  }) : super(
          path,
          overrideConfig: overrideConfig,
        );

  Future<FilterResultModel<T>> filter(FilterModel filter) async {
    final res = await dio.post(url("filter"), data: filter.toJson());
    return FilterResultModel.fromJson(res.data);
  }
}
