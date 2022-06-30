import 'package:example/pages/base-list/account-tile.widget.dart';
import 'package:example/pages/base-list/accounts.filter-provider.dart';
import 'package:example/pages/base-list/accounts.model.dart';
import 'package:example/pages/common/base.page.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class BaseListPage extends StatelessWidget {
  const BaseListPage();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Base list",
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return NiceBaseListConfig<Accounts>(
      config: NiceBaseListConfigData<Accounts>(
        dataFilterProvider: AccountsFilterProvider(),
        pageSize: 20,
        mode: NiceBaseListMode.InfiniteScroll,
        autoLoad: true,
      ),
      child: Column(
        children: [
          const NiceBaseListSearchBar<Accounts>(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 12,
                  color: Color(0x1F000000),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            debounceDuration: Duration(milliseconds: 0),
          ),
          Expanded(
            child: NiceBaseListBody<Accounts>.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              builder: (_, account) => AccountTile(account: account),
              separatorBuilder: (_) => const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}
