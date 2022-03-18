import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
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

  /// Config for the next button
  final NiceAccountCreationNextButtonConfig nextButtonConfig;

  /// Config for the previous button
  final NiceAccountCreationPreviousButtonConfig previousButtonConfig;

  /// Hide the buttons if the keyboard is visible
  final bool hideButtonsIfKeyboardVisible;

  /// Automatically unfocus on tap and on page change
  final bool unfocusOnInteraction;

  /// Constrained used for the next / previous buttons
  final BoxConstraints buttonConstraints;

  const NiceAccountCreationConfig({
    this.pageChangeDuration: const Duration(milliseconds: 200),
    this.pageChangeCurve: Curves.easeOut,
    this.defaultPageConfig: const NiceAccountCreationPageConfig(),
    required this.nextButtonText,
    required this.previousButtonText,
    this.pageViewPhysics: const NeverScrollableScrollPhysics(),
    required this.nextButtonConfig,
    required this.previousButtonConfig,
    this.hideButtonsIfKeyboardVisible: true,
    this.unfocusOnInteraction: true,
    this.buttonConstraints: const BoxConstraints(),
  });

  factory NiceAccountCreationConfig.of(BuildContext context) => Provider.of<NiceAccountCreationConfig>(context);
}
