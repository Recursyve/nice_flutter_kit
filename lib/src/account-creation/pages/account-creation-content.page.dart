import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationContentPage extends NiceAccountCreationLayoutPage {
  final Widget content;

  const NiceAccountCreationContentPage({
    NiceAccountCreationBaseEnabledStrategy enabledStrategy:
        const NiceAccountCreationAlwaysEnabledStrategy(),
    required NiceAccountCreationBaseValidationStrategy validationStrategy,
    NiceAccountCreationLayoutHeaderData headerData: const NiceAccountCreationLayoutHeaderData(),
    NiceAccountCreationPageConfig? pageConfig,
    required this.content,
  }) : super(
          enabledStrategy: enabledStrategy,
          validationStrategy: validationStrategy,
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
