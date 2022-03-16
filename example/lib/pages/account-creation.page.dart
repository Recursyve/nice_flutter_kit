import 'package:example/pages/common/base.page.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class AccountCreationPage extends StatelessWidget {
  const AccountCreationPage();

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      title: "Account creation",
      child: NiceAccountCreation(
        config: const NiceAccountCreationConfig(
          nextButtonText: "Next",
          previousButtonText: "Previous",
          defaultPageConfig: NiceAccountCreationPageConfig(
            titleStyle: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            titlePadding: EdgeInsets.symmetric(vertical: 8),
            subTitleStyle: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
            subTitlePadding: EdgeInsets.only(bottom: 32),
          ),
        ),
        pages: [
          NiceAccountCreationContentPage(
            enabled: true,
            headerData: NiceAccountCreationLayoutHeaderData(
              title: "Page 1",
              subTitle: "Subtitse test",
            ),
            content: Text("ALLO!"),
          ),
          NiceAccountCreationContentPage(
            enabled: true,
            headerData: NiceAccountCreationLayoutHeaderData(
              title: "Page 2",
            ),
            content: Text("ALLO!"),
          ),
        ],
      ),
    );
  }
}
