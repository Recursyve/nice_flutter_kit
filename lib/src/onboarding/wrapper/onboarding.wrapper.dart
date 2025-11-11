import "dart:collection";

import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceOnboardingWrapper extends StatefulWidget {
  final NiceOnboardingConfiguration configuration;
  final VoidCallback onCompleted;
  final ThemeData? theme;
  final HashMap<NicePermissionTypes, bool> isPermissionEnabled;

  const NiceOnboardingWrapper({
    super.key,
    required this.configuration,
    required this.onCompleted,
    required this.isPermissionEnabled,
    this.theme,
  });

  @override
  _NiceOnboardingWrapperState createState() => _NiceOnboardingWrapperState();
}

class _NiceOnboardingWrapperState extends State<NiceOnboardingWrapper> {
  final PageController _controller = PageController();
  late int pageCount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? Theme.of(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: widget.configuration.backgroundColor ?? Theme.of(context).colorScheme.surface,
            body: SafeArea(
              left: widget.configuration.safeArea.left,
              top: widget.configuration.safeArea.top,
              right: widget.configuration.safeArea.right,
              bottom: widget.configuration.safeArea.bottom,
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildWelcome(),
                  _buildIntroductionSequence(),
                  ..._buildPermissionSequence(),
                ].whereType<Widget>().toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? _buildWelcome() {
    if (widget.configuration.welcome == null) {
      return null;
    }

    return NiceOnboardingWelcomePage(
      configuration: widget.configuration.welcome!,
      onNext: _nextPage,
    );
  }

  Widget? _buildIntroductionSequence() {
    if (widget.configuration.introductionSequence == null) {
      return null;
    }

    return NiceOnboardingIntroductionSequence(
      sequenceConfiguration: widget.configuration.introductionSequence!,
      onNext: _nextPage,
    );
  }

  List<Widget> _buildPermissionSequence() {
    if (widget.configuration.permissionSequence == null) {
      return [];
    }

    widget.configuration.permissionSequence!.configurations.removeWhere(
      (permission) => widget.isPermissionEnabled[permission.type]!,
    );

    return [
      for (final configuration in widget.configuration.permissionSequence!.configurations)
        NiceOnboardingPermissionPage(
          configuration: configuration,
          onNext: _nextPage,
        ),
    ];
  }

  void _nextPage() {
    pageCount = widget.configuration.pageCount;
    if (_controller.page! + 1 >= pageCount) {
      widget.onCompleted();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }
  }
}
