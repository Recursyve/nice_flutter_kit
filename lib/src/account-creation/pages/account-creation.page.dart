import 'package:flutter/cupertino.dart';

/// Base page for a step of the account creation
/// To make a full custom page, extend this class and implement the [buildPage] method
abstract class NiceAccountCreationPage {
  /// Whether this page should be enabled
  /// A disabled page will be completely ignored
  final bool enabled;

  const NiceAccountCreationPage({
    required this.enabled,
  });

  /// Page builder, ie. the content of the [PageView]
  Widget buildPage(BuildContext context);
}
