import 'package:nice_flutter_kit/nice-flutter-kit-config.dart';

abstract class NiceBaseApi {
  final NiceFlutterKitApiConfig? overrideConfig;
  final String path;

  const NiceBaseApi(
    this.path, {
    this.overrideConfig,
  });

  String get _apiUrl {
    assert(NiceFlutterKitConfig.defaultApiConfig != null || overrideConfig != null);
    return overrideConfig?.url ?? NiceFlutterKitConfig.defaultApiConfig!.url;
  }

  String url([String? route]) {
    return route != null ? "$_apiUrl/$path/$route" : "$_apiUrl/$path";
  }

  String prefixedUrl(String prefix, [String? route]) {
    return route != null ? "$_apiUrl/$prefix/$path/$route" : "$_apiUrl/$prefix/$path";
  }
}
