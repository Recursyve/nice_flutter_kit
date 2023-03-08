import 'package:nice_flutter_kit/nice_flutter_kit.dart';

/// Config that will be used to determine the behavior of the base list.
class NiceBaseListConfigData<D> {
  /// Provider that will be used to provide values.
  final NiceBaseListDataFilterProvider<D> dataFilterProvider;

  /// Page size of the base list.
  /// Defaults to 20.
  final int pageSize;

  /// Initial page of the base list.
  /// In most cases, this should be left to the default value of 0.
  final int initialPage;

  /// Initial [NiceFilterOrderModel].
  final NiceFilterOrderModel? initialOrder;

  /// Initial [NiceFilterQueryModel].
  final NiceFilterQueryModel? initialQuery;

  /// Initial [NiceFilterSearchModel].
  final NiceFilterSearchModel? initialSearch;

  /// Whether the base list should autoload on initialization.
  /// Defaults to true.
  final bool autoLoad;

  /// The [NiceBaseListMode] that is going to be used by the base list.
  /// Defaults to [NiceBaseListMode.InfiniteScroll].
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
