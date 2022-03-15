import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation-page.config.dart';
import 'package:nice_flutter_kit/src/account-creation/pages/account-creation.page.dart';

/// Base page for a step that has a title / subtitle and content
/// Title, subTitle and content style / alignment will depend on the [NiceAccountCreationPageConfig] passed
abstract class NiceAccountCreationLayoutPage extends NiceAccountCreationPage {
  /// Title of the page, displayed according to [pageConfig]
  /// If [titleBuilder] is passed, [title] will be ignored
  final String? title;

  /// Title builder of the page. Takes over [title]
  final WidgetBuilder? titleBuilder;

  /// Sub title of teh page, displayed under [title]/[titleBuilder] according to [pageConfig]
  /// If [subTitleBuilder] is passed, [subTitle] will be ignored
  final String? subTitle;

  // Sub title builder of the page. Takes over [subTitle]
  final WidgetBuilder? subTitleBuilder;

  bool get _hasTitle => title != null || titleBuilder != null;

  bool get _hasSubTitle => subTitle != null || subTitleBuilder != null;

  const NiceAccountCreationLayoutPage({
    this.title,
    this.titleBuilder,
    this.subTitle,
    this.subTitleBuilder,
  });

  /// Build the page layout around [child] according to [pageConfig]
  @mustCallSuper
  Widget buildLayout({
    required NiceAccountCreationPageConfig pageConfig,
    required Widget child,
  }) {
    return Column(
      children: [
        if (_hasTitle || _hasSubTitle) _buildHeader(pageConfig),
        child,
      ],
    );
  }

  Widget _buildHeader(NiceAccountCreationPageConfig pageConfig) {
    return Builder(
      builder: (context) => Column(
        children: [
          if (_hasTitle)
            Padding(
              padding: pageConfig.titlePadding,
              child: Align(
                alignment: pageConfig.titleAlignment,
                child: DefaultTextStyle(
                  style: pageConfig.titleStyle,
                  child: titleBuilder?.call(context) ?? Text(title!),
                ),
              ),
            ),
          if (_hasSubTitle)
            Padding(
              padding: pageConfig.subTitlePadding,
              child: Align(
                alignment: pageConfig.subTitleAlignment,
                child: DefaultTextStyle(
                  style: pageConfig.subTitleStyle,
                  child: subTitleBuilder?.call(context) ?? Text(subTitle!),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
