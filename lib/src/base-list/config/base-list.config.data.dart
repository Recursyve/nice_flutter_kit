import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list-data-filter.provider.dart';

class NiceBaseListConfigData {
  final INiceBaseListDataFilterService dataFilterService;
  final NiceFilterModel? defaultFilter;
  final bool autoLoad;

  const NiceBaseListConfigData({
    required this.dataFilterService,
    this.defaultFilter,
    this.autoLoad = true,
  });
}
