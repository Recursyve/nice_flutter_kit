import 'dart:math' as math;

import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list-data-filter.provider.dart';

import 'mock_data.dart';

class MockDataFilterProvider implements NiceBaseListDataFilterProvider<MockData> {
  final values = [
    for (int i = 0; i < 200; i++)
      MockData(
        id: i,
        name: "Mock data #$i",
      ),
  ];

  @override
  Future<NiceFilterResultModel<MockData>> filter(NiceFilterModel filter) async {
    return NiceFilterResultModel(
      page: NiceFilterResultPageModel(
        number: filter.page.number,
        size: filter.page.size,
      ),
      total: values.length,
      values: generateValues(filter.page),
    );
  }

  List<MockData> generateValues(NiceFilterPageModel page) {
    final start = page.number * page.size;
    if (start > this.values.length) return const [];

    return this.values.sublist(start, math.min(start + page.size, this.values.length));
  }
}
