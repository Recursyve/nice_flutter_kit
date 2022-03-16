import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationContentBuilderPage extends NiceAccountCreationLayoutPage {
  final WidgetBuilder contentBuilder;

  const NiceAccountCreationContentBuilderPage({
    bool enabled: true,
    NiceAccountCreationLayoutHeaderData headerData: const NiceAccountCreationLayoutHeaderData(),
    NiceAccountCreationPageConfig? pageConfig,
    required this.contentBuilder,
  }) : super(
          enabled: enabled,
          headerData: headerData,
          pageConfig: pageConfig,
        );

  @override
  Widget buildPage(BuildContext context) {
    return super.buildLayout(
      child: contentBuilder(context),
    );
  }
}
