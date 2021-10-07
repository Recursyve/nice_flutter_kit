import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/configs/config.dart';
import 'package:nice_flutter_kit/onboarding/introduction/onboarding-introduction.wrapper.dart';
import 'package:nice_flutter_kit/onboarding/onboarding.configuration.dart';
import 'package:nice_flutter_kit/onboarding/permission/onboarding-permission-sequence.configuration.dart';
import 'package:nice_flutter_kit/onboarding/permission/onboarding-permission.page.dart';
import 'package:nice_flutter_kit/onboarding/welcome/onboarding-welcome.page.dart';

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
    pageCount = widget.configuration.pageCount;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildWelcome(),
                _buildIntroductionSequence(),
                ..._buildPermissionSequence(),
              ].whereType<Widget>().toList(),
            )
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

    if (widget.configuration.permissionSequence != null)
    return widget.configuration.permissionSequence!.configurations!
        .map(
          (permission) => NiceOnboardingPermissionPage(
              configuration: permission, onNext: _nextPage),
        )
        .toList();
    else{
      return [];
    }
  }

  void _nextPage() {
    if (_controller.page! + 1 >= pageCount) {
      widget.onCompleted();
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }
  }
}
