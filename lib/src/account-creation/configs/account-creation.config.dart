import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation-page.config.dart';
import 'package:provider/provider.dart';

class NiceAccountCreationConfig {
  /// Duration it takes for the animation of a page change
  final Duration pageChangeDuration;

  /// Curve used for the animation fo a page change
  final Curve pageChangeCurve;

  final NiceAccountCreationPageConfig defaultPageConfig;

  /// Text displayed in the "next" button
  final String nextButtonText;

  /// Text displayed in the "previous" button
  final String previousButtonText;

  /// The physics applied to the page view. By default, we use [NeverScrollableScrollPhysics]
  final ScrollPhysics pageViewPhysics;

  const NiceAccountCreationConfig({
    this.pageChangeDuration: const Duration(milliseconds: 200),
    this.pageChangeCurve: Curves.easeOut,
    this.defaultPageConfig: const NiceAccountCreationPageConfig(),
    required this.nextButtonText,
    required this.previousButtonText,
    this.pageViewPhysics: const NeverScrollableScrollPhysics(),
  });

  factory NiceAccountCreationConfig.of(BuildContext context) => Provider.of<NiceAccountCreationConfig>(context);
}
