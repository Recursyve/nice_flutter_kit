import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

/// Base page for a step of the account creation
/// To make a full custom page, extend this class and implement the [buildPage] method
abstract class NiceAccountCreationBasePage {
  /// Whether this page should be enabled
  /// A disabled page will be completely ignored
  final NiceAccountCreationBaseEnabledStrategy enabledStrategy;
  final NiceAccountCreationBaseValidationStrategy validationStrategy;

  const NiceAccountCreationBasePage({
    required this.enabledStrategy,
    required this.validationStrategy,
  });

  /// Page builder, ie. the content of the [PageView]
  Widget buildPage(BuildContext context);
}
