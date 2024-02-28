import "package:example/pages/base-list/account-tile.widget.dart";
import "package:example/pages/base-list/accounts.filter-provider.dart";
import "package:example/pages/base-list/accounts.model.dart";
import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class InfiniteScrollLoadedBaseListPage extends StatelessWidget {
  const InfiniteScrollLoadedBaseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Infinite scroll base list",
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return NiceBaseListConfig<Accounts>(
      config: NiceBaseListConfigData<Accounts>(
        dataFilterProvider: AccountsFilterProvider(),
      ),
      child: NiceBaseListLoadingIndicator<Accounts>(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: NiceBaseListSearchBar<Accounts>(
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
                inputDecoration: InputDecoration(
                  hintText: "Search...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: NiceBaseListEmptyState<Accounts>(
                emptyStateBuilder: (context) => const Center(
                  child: Text("Empty state"),
                ),
                child: NiceBaseListBody<Accounts>.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  builder: (_, account) => AccountTile(account: account),
                  separatorBuilder: (_) => const SizedBox(height: 16),
                  pageLoadingIndicator: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: LinearProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
