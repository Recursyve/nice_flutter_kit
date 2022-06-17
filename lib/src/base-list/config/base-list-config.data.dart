import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list-data-filter.provider.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list-mode.enum.dart';

class NiceBaseListConfigData<D> {
  final NiceBaseListDataFilterProvider<D> dataFilterProvider;

  final int pageSize;
  final int initialPage;

  final NiceFilterOrderModel? initialOrder;
  final NiceFilterQueryModel? initialQuery;
  final NiceFilterSearchModel? initialSearch;

  final bool autoLoad;
  final NiceBaseListMode mode;

  const NiceBaseListConfigData({
    required this.dataFilterProvider,
    this.pageSize = 20,
    this.initialPage = 0,
    this.initialOrder,
    this.initialQuery,
    this.initialSearch,
    this.autoLoad = true,
    this.mode = NiceBaseListMode.InfiniteScroll,
  });
}
