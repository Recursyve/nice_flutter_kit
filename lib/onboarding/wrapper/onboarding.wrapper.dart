import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/onboarding/introduction/onboarding-introduction.wrapper.dart';
import 'package:nice_flutter_kit/onboarding/onboarding.configuration.dart';
import 'package:nice_flutter_kit/onboarding/permission/onboarding-permission.page.dart';
import 'package:nice_flutter_kit/onboarding/welcome/onboarding-welcome.page.dart';

class NiceOnboardingWrapper extends StatefulWidget {
  final NiceOnboardingConfiguration configuration;
  final VoidCallback onCompleted;

  NiceOnboardingWrapper({
    required this.configuration,
    required this.onCompleted,
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
    pageCount = widget.configuration.countPages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<List<bool>>(
        future: Future.wait([
          // TODO: Need to skip permissions that are already granted.
          // FcmService.isPermissionGranted(),
          // GeolocationService.isPermissionGranted(),
        ]),
        builder: (context, snapshot) {
          // final notificationAlreadyEnabled = snapshot.data?[0] ?? false;
          // final geolocationAlreadyEnabled = snapshot.data?[1] ?? false;

          return PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildWelcome(),
              _buildIntroductionSequence(),
              ..._buildPermissionSequence(),
            ].whereType<Widget>().toList(),
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
    return [
      if (widget.configuration.permissionSequence != null)
        for (final permission in widget.configuration.permissionSequence!.configurations)
          NiceOnboardingPermissionPage(
            configuration: permission,
            onNext: _nextPage,
          ),
    ];
  }

  void _nextPage() {
    if (_controller.page! + 1 >= pageCount) {
      widget.onCompleted();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }
  }
}
