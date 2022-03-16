import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation.config.dart';
import 'package:nice_flutter_kit/src/account-creation/pages/account-creation.page.dart';
import 'package:provider/provider.dart';

class NiceAccountCreation extends StatefulWidget {
  final NiceAccountCreationConfig config;
  final List<NiceAccountCreationPage> pages;

  const NiceAccountCreation({
    required this.config,
    required this.pages,
  });

  @override
  State<NiceAccountCreation> createState() => _NiceAccountCreationState();
}

class _NiceAccountCreationState extends State<NiceAccountCreation> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NiceAccountCreationConfig>.value(
      value: widget.config,
      child: Column(
        children: [
          Expanded(
            child: PageView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return KeyedSubtree(
                    key: ValueKey<int>(index),
                    child: widget.pages[index].buildPage(context),
                  );
                },
                childCount: widget.pages.length, // TODO: hidden pages
                findChildIndexCallback: (Key key) {
                  final originalIndex = (key as ValueKey<int>).value;
                  return originalIndex;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
