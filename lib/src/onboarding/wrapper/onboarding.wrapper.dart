import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceOnboardingWrapper extends StatefulWidget {
  final NiceOnboardingConfiguration configuration;
  final VoidCallback onCompleted;
  final ThemeData? theme;

  NiceOnboardingWrapper({
    required this.configuration,
    required this.onCompleted,
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
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
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
        }
      ),
      data: widget.theme ?? Theme.of(context),
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
      (permission) => (NiceConfig.onboardingConfig!.isPermissionEnabled[permission.type]!),
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
