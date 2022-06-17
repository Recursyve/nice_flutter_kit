import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class NiceBaseListDataFilterProvider<D> {
  const NiceBaseListDataFilterProvider();

  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter);
}

class NiceBaseListDataFilterApiProvider<D> implements NiceBaseListDataFilterProvider<D> {
  final NiceDataFilterApi<D> api;

  const NiceBaseListDataFilterApiProvider({
    required this.api,
  });

  @override
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter) => api.filter(filter);
}
