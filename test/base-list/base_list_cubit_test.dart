import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list-mode.enum.dart';
import 'package:test/test.dart';

import 'mock_data.dart';
import 'mock_data_filter_provider.dart';

void main() {
  group("NiceBaseListCubit", () {
    late final NiceBaseListCubit<MockData> cubit;

    setUp(() {
      cubit = NiceBaseListCubit(
        config: NiceBaseListConfigData(
          dataFilterProvider: MockDataFilterProvider(),
          mode: NiceBaseListMode.InfiniteScroll,
          initialOrder: const NiceFilterOrderModel(
            column: "id",
            direction: NiceFilterOrderDirections.Desc,
          ),
          pageSize: 13,
        ),
      );
    });

    expect("Cubit to apply initial config and load initial values", () async {
      expect(cubit.state.nextPage, 0);
      expect(cubit.state.values.length, 0);

      await cubit.applyDefaultConfigAndMaybeLoad();

      expect(cubit.state.order?.column, "id");
      expect(cubit.state.order?.direction, NiceFilterOrderDirections.Desc);

      expect(cubit.state.values.length, 13);
      expect(cubit.state.nextPage, 1);
    });
  });
}
