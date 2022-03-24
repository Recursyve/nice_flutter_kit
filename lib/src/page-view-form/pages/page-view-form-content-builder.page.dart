import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NicePageViewFormContentBuilderPage extends NicePageViewFormLayoutPage {
  final WidgetBuilder contentBuilder;

  const NicePageViewFormContentBuilderPage({
    NicePageViewFormBaseEnabledStrategy enabledStrategy: const NicePageViewFormAlwaysEnabledStrategy(),
    required NicePageViewFormBaseValidationStrategy validationStrategy,
    NicePageViewFormLayoutHeaderData headerData: const NicePageViewFormLayoutHeaderData(),
    NicePageViewFormPageConfig? pageConfig,
    required this.contentBuilder,
  }) : super(
          enabledStrategy: enabledStrategy,
          validationStrategy: validationStrategy,
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
