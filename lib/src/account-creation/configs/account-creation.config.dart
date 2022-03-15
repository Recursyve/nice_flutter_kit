import 'package:flutter/animation.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation-page.config.dart';

class NiceAccountCreationConfig {
  /// Duration it takes for the animation of a page change
  final Duration pageChangeDuration;

  /// Curve used for the animation fo a page change
  final Curve pageChangeCurve;

  final NiceAccountCreationPageConfig pageConfig;

  /// Text displayed in the "next" button
  final String nextButtonText;

  /// Text displayed in the "previous" button
  final String previousButtonText;

  const NiceAccountCreationConfig({
    this.pageChangeDuration: const Duration(milliseconds: 200),
    this.pageChangeCurve: Curves.easeOut,
    this.pageConfig: const NiceAccountCreationPageConfig(),
    required this.nextButtonText,
    required this.previousButtonText,
  });
}
