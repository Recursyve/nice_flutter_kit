import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Provider that is responsible to filter values, by converting a [NiceFilterModel] to a [NiceFilterResultModel].
/// This class can be either implemented (recommended), or extended.
abstract class NiceBaseListDataFilterProvider<D> {
  const NiceBaseListDataFilterProvider();

  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter);
}

/// [NiceBaseListDataFilterProvider] implementation for [NiceDataFilterApi].
class NiceBaseListDataFilterApiProvider<D> implements NiceBaseListDataFilterProvider<D> {
  final NiceDataFilterApi<D> api;

  const NiceBaseListDataFilterApiProvider({
    required this.api,
  });

  @override
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter) => api.filter(filter);
}
