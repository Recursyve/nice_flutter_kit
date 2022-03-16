import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation-page.config.dart';
import 'package:nice_flutter_kit/src/account-creation/pages/account-creation-layout.page.dart';

class NiceAccountCreationContentPage extends NiceAccountCreationLayoutPage {
  final Widget content;

  const NiceAccountCreationContentPage({
    bool enabled: true,
    NiceAccountCreationLayoutHeaderData headerData: const NiceAccountCreationLayoutHeaderData(),
    NiceAccountCreationPageConfig? pageConfig,
    required this.content,
  }) : super(
          enabled: enabled,
          headerData: headerData,
          pageConfig: pageConfig,
        );

  @override
  Widget buildPage(BuildContext context) {
    return super.buildLayout(
      child: content,
    );
  }
}
