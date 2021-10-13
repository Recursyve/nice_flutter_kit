import 'package:nice_flutter_kit/configs/api.config.dart';
import 'package:nice_flutter_kit/configs/config.dart';

abstract class NiceBaseApi {
  final NiceApiConfig? overrideConfig;
  final String path;

  const NiceBaseApi(
    this.path, {
    this.overrideConfig,
  });

  String get _apiUrl {
    assert(NiceConfig.defaultApiConfig != null || overrideConfig != null,
        "NiceApi wasn't initialized, please provide NiceApiConfig in main");
    return overrideConfig?.url ?? NiceConfig.defaultApiConfig!.url;
  }

  String url([String? route]) {
    return route != null ? "$_apiUrl/$path/$route" : "$_apiUrl/$path";
  }

  String prefixedUrl(String prefix, [String? route]) {
    return route != null ? "$_apiUrl/$prefix/$path/$route" : "$_apiUrl/$prefix/$path";
  }
}
