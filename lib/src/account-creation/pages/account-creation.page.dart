import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/src/account-creation/configs/account-creation-page.config.dart';

/// Base page for a step of the account creation
/// To make a full custom page, extend this class and implement the [buildPage] method
abstract class NiceAccountCreationPage {
  const NiceAccountCreationPage();

  Widget buildPage(BuildContext context, NiceAccountCreationPageConfig pageConfig);
}
