import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NicePageViewFormContentPage extends NicePageViewFormLayoutPage {
  final Widget content;

  const NicePageViewFormContentPage({
    NicePageViewFormBaseEnabledStrategy enabledStrategy:
        const NicePageViewFormAlwaysEnabledStrategy(),
    required NicePageViewFormBaseValidationStrategy validationStrategy,
    NicePageViewFormLayoutHeaderData headerData: const NicePageViewFormLayoutHeaderData(),
    NicePageViewFormPageConfig? pageConfig,
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
