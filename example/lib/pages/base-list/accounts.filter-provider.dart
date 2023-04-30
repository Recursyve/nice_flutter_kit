import "package:example/pages/base-list/accounts.model.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class AccountsFilterProvider implements NiceBaseListDataFilterProvider<Accounts> {
  @override
  Future<NiceFilterResultModel<Accounts>> filter(NiceFilterModel filter) async {
    final startIndex = filter.page.number * filter.page.size;

    final filteredAccounts = Accounts.generatedAccounts
        .where(
          (account) => account.matchesSearchQuery(filter.search?.value ?? ""),
        )
        .toList(growable: false);

    final List<Accounts> values;
    if (filteredAccounts.length < startIndex) {
      values = [];
    } else if (filteredAccounts.length < startIndex + filter.page.size) {
      values = filteredAccounts.sublist(startIndex);
    } else {
      values = filteredAccounts.sublist(startIndex, startIndex + filter.page.size);
    }

    await Future.delayed(Duration(milliseconds: 200 + values.length * 10));

    return NiceFilterResultModel(
      page: NiceFilterResultPageModel(
        number: filter.page.number,
        size: filter.page.size,
      ),
      total: filteredAccounts.length,
      values: values,
    );
  }
}
