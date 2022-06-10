import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class NiceBaseListDataFilterService<D> {
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel params);
}

class NiceBaseListDataFilterApiService<D> implements NiceBaseListDataFilterService<D> {
  final NiceDataFilterApi<D> api;

  const NiceBaseListDataFilterApiService({
    required this.api,
  });

  @override
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter) => api.filter(filter);
}
