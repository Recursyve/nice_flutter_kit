import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class INiceBaseListDataFilterService<D> {
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel params);
}

class NiceBaseListDataFilterService<D> implements INiceBaseListDataFilterService<D> {
  final NiceDataFilterApi<D> api;

  const NiceBaseListDataFilterService({
    required this.api,
  });

  @override
  Future<NiceFilterResultModel<D>> filter(NiceFilterModel filter) => api.filter(filter);
}
