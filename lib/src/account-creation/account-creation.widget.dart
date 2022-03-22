import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/account-creation/widgets/nice-account-creation-buttons.widget.dart';
import 'package:provider/provider.dart';

class NiceAccountCreation extends StatefulWidget {
  /// Config used for the account creation
  final NiceAccountCreationConfig config;

  /// Controller used for the page view
  /// This can be used to change pages from outside of the [NiceAccountCreation] widget, for example go to the previous
  /// page when the back button of an app bar is pressed
  /// If not null, this widget won't dispose it
  final PageController? pageController;

  /// Pages that will be displayed in the account creation page view
  final List<NiceAccountCreationBasePage> pages;

  /// Called whenever the current [PageView] page changes
  /// [index] represents the index of the page in the [PageView]
  /// [realIndex] represent index of the page in [pages]
  /// These indexes can differ if we are hiding pages
  final void Function(int index, int realIndex)? onPageChange;

  /// Called when the user is at the last page and presses the "next" button
  final VoidCallback onSubmit;

  NiceAccountCreation({
    required this.config,
    this.pageController,
    required this.pages,
    this.onPageChange,
    required this.onSubmit,
  }) : assert(pages.isNotEmpty);

  @override
  State<NiceAccountCreation> createState() => _NiceAccountCreationState();
}

class _NiceAccountCreationState extends State<NiceAccountCreation> {
  late final _localPageController;

  PageController get _pageController => widget.pageController ?? _localPageController;

  @override
  void initState() {
    super.initState();

    if (widget.pageController == null) {
      _localPageController = PageController();
    }
  }

  @override
  void dispose() {
    if (widget.pageController == null) {
      // Only dispose of the PageController if it was created by this widget
      _localPageController.dispose();
    }
    super.dispose();
  }

  int get _pageViewPageIndex {
    if (!_pageController.hasClients) return _pageController.initialPage;
    return _pageController.page?.round() ?? _pageController.initialPage;
  }

  List<NiceAccountCreationBasePage> get _enabledPages => [
        for (final page in widget.pages)
          if (page.enabledStrategy.isEnabled(context)) page,
      ];

  int get _enabledPageCount => _enabledPages.length;

  Future<void> _onNext() async {
    _unfocusIfEnabled();
    final currentPage = _enabledPages.elementAt(_pageViewPageIndex);
    if (!await currentPage.validationStrategy.isValid(context)) {
      return;
    }

    if (_pageViewPageIndex == _enabledPageCount - 1) {
      widget.onSubmit();
      return;
    }

    await _pageController.nextPage(
      duration: widget.config.pageChangeDuration,
      curve: widget.config.pageChangeCurve,
    );
  }

  Future<void> _onPrevious() async {
    _unfocusIfEnabled();
    await _pageController.previousPage(
      duration: widget.config.pageChangeDuration,
      curve: widget.config.pageChangeCurve,
    );
  }

  void _unfocusIfEnabled() {
    if (!widget.config.unfocusOnInteraction) return;
    final focusScope = FocusScope.of(context);
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NiceAccountCreationConfig>.value(
      value: widget.config,
      child: WillPopScope(
        onWillPop: () async {
          if (_pageViewPageIndex == 0) return true;
          _onPrevious();
          return false;
        },
        child: Column(
          children: [
            Expanded(
              child: _buildPageView(),
            ),
            ConstrainedBox(
              constraints: widget.config.buttonConstraints,
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) => NiceAccountCreationButtons(
                  currentPageIndex: _pageViewPageIndex,
                  pageCount: _enabledPageCount,
                  onNext: _onNext,
                  onPrevious: _onPrevious,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Builder(
      builder: (context) {
        Widget child = PageView(
          controller: _pageController,
          physics: widget.config.pageViewPhysics,
          children: [
            for (final page in _enabledPages) page.buildPage(context),
          ],
        );

        if (widget.config.unfocusOnInteraction) {
          child = NiceAutomaticUnfocus(child: child);
        }
        return child;
      },
    );
  }
}
