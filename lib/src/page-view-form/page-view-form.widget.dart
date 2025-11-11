import "dart:async";

import "package:flutter/cupertino.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:nice_flutter_kit/src/page-view-form/widgets/page-view-form-buttons.widget.dart";
import "package:provider/provider.dart";

class NicePageViewForm extends StatefulWidget {
  /// Config used for the page view form
  final NicePageViewFormConfig config;

  /// Controller used for the page view
  /// This can be used to change pages from outside of the [NicePageViewForm] widget, for example go to the previous
  /// page when the back button of an app bar is pressed
  /// If not null, this widget won't dispose it
  final PageController? pageController;

  /// Pages that will be displayed in the [NicePageViewForm] page view
  final List<NicePageViewFormPage> pages;

  /// Called whenever the current [PageView] page changes
  /// [index] represents the index of the page in the [PageView]
  /// [realIndex] represent index of the page in [pages]
  /// These indexes can differ if we are hiding pages
  final void Function(int index, int realIndex)? onPageChange;

  /// Called when the user is at the last page and presses the "next" button
  final VoidCallback onSubmit;

  NicePageViewForm({
    super.key,
    required this.config,
    this.pageController,
    required this.pages,
    this.onPageChange,
    required this.onSubmit,
  }) : assert(pages.isNotEmpty);

  @override
  State<NicePageViewForm> createState() => _NicePageViewFormState();
}

class _NicePageViewFormState extends State<NicePageViewForm> {
  late final PageController? _localPageController;

  PageController get _pageController => widget.pageController ?? _localPageController!;

  @override
  void initState() {
    super.initState();

    _localPageController = widget.pageController == null ? PageController() : null;
  }

  @override
  void dispose() {
    // Only dispose of the PageController if it was created by this widget
    _localPageController?.dispose();
    super.dispose();
  }

  int get _pageViewPageIndex {
    if (!_pageController.hasClients) {
      return _pageController.initialPage;
    }
    return _pageController.page?.round() ?? _pageController.initialPage;
  }

  List<NicePageViewFormPage> get _enabledPages => [
        for (final page in widget.pages)
          if (page.enabledStrategy.isEnabled(context)) page,
      ];

  int get _enabledPageCount => _enabledPages.length;

  Future<void> _onNext() async {
    _unfocusIfEnabled();
    final currentPage = _enabledPages.elementAt(_pageViewPageIndex);
    // ignore: use_build_context_synchronously
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
    if (!widget.config.unfocusOnInteraction) {
      return;
    }
    final focusScope = FocusScope.of(context);
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("new new");
    return Provider<NicePageViewFormConfig>.value(
      value: widget.config,
      // AnimatedBuilder is necessary so the canPop: _pageViewPageIndex is updated on page change.
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (context, _) => PopScope(
          canPop: _pageViewPageIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && _pageViewPageIndex != 0) {
              unawaited(_onPrevious());
            }
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
                  builder: (context, _) => NicePageViewFormButtons(
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
