import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationLayoutHeaderData {
  /// Title of the page, displayed according to [defaultPageConfig]
  /// If [titleBuilder] is passed, [title] will be ignored
  final String? title;

  /// Title builder of the page. Takes over [title]
  final WidgetBuilder? titleBuilder;

  /// Sub title of the page, displayed under [title]/[titleBuilder] according to [defaultPageConfig]
  /// If [subTitleBuilder] is passed, [subTitle] will be ignored
  final String? subTitle;

  // Sub title builder of the page. Takes over [subTitle]
  final WidgetBuilder? subTitleBuilder;

  bool get hasTitle => title != null || titleBuilder != null;

  bool get hasSubTitle => subTitle != null || subTitleBuilder != null;

  bool get hasHeader => hasTitle || hasSubTitle;

  const NiceAccountCreationLayoutHeaderData({
    this.title,
    this.titleBuilder,
    this.subTitle,
    this.subTitleBuilder,
  });
}

/// Base page for a step that has a title / subtitle and content
/// Title, subTitle and content style / alignment will depend on the [NiceAccountCreationPageConfig] passed
abstract class NiceAccountCreationLayoutPage extends NiceAccountCreationBasePage {
  final NiceAccountCreationLayoutHeaderData headerData;
  final NiceAccountCreationPageConfig? pageConfig;

  const NiceAccountCreationLayoutPage({
    required NiceAccountCreationBaseEnabledStrategy enabledStrategy,
    required NiceAccountCreationBaseValidationStrategy validationStrategy,
    required this.headerData,
    this.pageConfig,
  }) : super(
          enabledStrategy: enabledStrategy,
          validationStrategy: validationStrategy,
        );

  /// Build the page layout around [child] according to [pageConfig] or [defaultPageConfig]
  @mustCallSuper
  Widget buildLayout({
    required Widget child,
  }) {
    // For now, only the content (child) will be scrollable, and not the header. It doesn't seem possible to align the
    // content if the header is in the same scrollable

    return Builder(
      builder: (context) {
        final defaultPageConfig = NiceAccountCreationConfig.of(context).defaultPageConfig;
        final constraints = pageConfig?.pageConstraints ?? defaultPageConfig.pageConstraints ?? const BoxConstraints();

        final contentAlignment =
            pageConfig?.contentAlignment ?? defaultPageConfig.contentAlignment ?? Alignment.topCenter;
        final contentPadding = pageConfig?.contentPadding ?? defaultPageConfig.contentPadding ?? EdgeInsets.zero;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (headerData.hasHeader)
              ConstrainedBox(
                constraints: constraints,
                child: _buildHeader(),
              ),
            Expanded(
              child: Align(
                alignment: contentAlignment,
                child: ConstrainedBox(
                  constraints: constraints,
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: contentAlignment,
                      child: Padding(
                        padding: contentPadding,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Builder(
      builder: (context) {
        final defaultPageConfig = NiceAccountCreationConfig.of(context).defaultPageConfig;

        return Column(
          children: [
            if (headerData.hasTitle)
              Padding(
                padding: pageConfig?.titlePadding ?? defaultPageConfig.titlePadding ?? EdgeInsets.zero,
                child: Align(
                  alignment: pageConfig?.titleAlignment ?? defaultPageConfig.titleAlignment ?? Alignment.center,
                  child: DefaultTextStyle(
                    style: pageConfig?.titleStyle ?? defaultPageConfig.titleStyle ?? DefaultTextStyle.of(context).style,
                    textAlign: pageConfig?.titleTextAlign ?? defaultPageConfig.titleTextAlign,
                    child: headerData.titleBuilder?.call(context) ?? Text(headerData.title!),
                  ),
                ),
              ),
            if (headerData.hasSubTitle)
              Padding(
                padding: pageConfig?.subTitlePadding ?? defaultPageConfig.subTitlePadding ?? EdgeInsets.zero,
                child: Align(
                  alignment: pageConfig?.subTitleAlignment ?? defaultPageConfig.subTitleAlignment ?? Alignment.center,
                  child: DefaultTextStyle(
                    style: pageConfig?.subTitleStyle ??
                        defaultPageConfig.subTitleStyle ??
                        DefaultTextStyle.of(context).style,
                    textAlign: pageConfig?.subTitleTextAlign ?? defaultPageConfig.subTitleTextAlign,
                    child: headerData.subTitleBuilder?.call(context) ?? Text(headerData.subTitle!),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
