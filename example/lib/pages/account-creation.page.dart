import 'package:example/pages/common/base.page.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AccountCreationPage extends StatelessWidget {
  const AccountCreationPage();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Account creation",
      child: ReactiveFormBuilder(
        form: () => fb.group(
          {
            "page3Enabled": fb.control(true),
            "someField": fb.control("", [Validators.required]),
            "password": fb.group(
              {
                "password": fb.control("", [Validators.required, Validators.minLength(8)]),
                "passwordConfirmation": fb.control("", [Validators.required]),
              },
              [
                Validators.mustMatch("password", "passwordConfirmation"),
              ],
            ),
            "email": fb.group(
              {
                "email": fb.control("", [Validators.required, Validators.email]),
                "emailConfirmation": fb.control("", [Validators.required]),
              },
              [
                Validators.mustMatch("email", "emailConfirmation"),
              ],
            ),
          },
        ),
        builder: (context, formGroup, _) => NiceAccountCreation(
          config: NiceAccountCreationConfig(
            nextButtonText: "Next",
            previousButtonText: "Previous",
            defaultPageConfig: const NiceAccountCreationPageConfig(
              titleStyle: TextStyle(
                fontSize: 24,
                color: Colors.blue,
              ),
              titlePadding: EdgeInsets.symmetric(vertical: 8),
              subTitleStyle: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
              subTitleTextAlign: TextAlign.center,
              subTitlePadding: EdgeInsets.only(bottom: 32),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              pageConstraints: BoxConstraints(
                maxWidth: 350,
              ),
            ),
            buttonConstraints: const BoxConstraints(
              maxWidth: 350,
            ),
            nextButtonConfig: NiceAccountCreationNextButtonConfig(
              text: "Next",
              submitText: "Create account",
              elevated: true,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            previousButtonConfig: NiceAccountCreationPreviousButtonConfig(
              text: "Previous",
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              boundReachedState: NiceAccountCreationButtonBoundReachedState.Disabled,
            ),
          ),
          pages: [
            const NiceAccountCreationContentPage(
              validationStrategy: AccountCreationAlwaysValidValidationStrategy(),
              headerData: NiceAccountCreationLayoutHeaderData(
                title: "Page 1",
                subTitle: "Subtitle test",
              ),
              content: Text("This is the account creation first page"),
            ),
            NiceAccountCreationContentPage(
              validationStrategy: const AccountCreationAlwaysValidValidationStrategy(),
              headerData: const NiceAccountCreationLayoutHeaderData(
                title: "Page 2",
              ),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Show page 3"),
                  ReactiveCheckbox(
                    formControlName: "page3Enabled",
                  ),
                ],
              ),
            ),
            NiceAccountCreationContentPage(
              enabledStrategy: NiceAccountCallbackEnabledStrategy(
                callback: (context) => (ReactiveForm.of(context) as FormGroup).control("page3Enabled").value,
              ),
              validationStrategy: const AccountCreationAlwaysValidValidationStrategy(),
              headerData: const NiceAccountCreationLayoutHeaderData(
                title: "Page 3",
              ),
              content: const Text("This is page 3"),
            ),
            NiceAccountCreationEmailPage(
              headerData: const NiceAccountCreationLayoutHeaderData(
                title: "Email",
                subTitle: "Please enter your email",
              ),
              pageConfig: const NiceAccountCreationPageConfig(contentAlignment: Alignment.center),
              emailDecoration: const InputDecoration(
                hintText: "Email",
              ),
              emailConfirmationDecoration: const InputDecoration(
                hintText: "Email confirmation",
              ),
            ),
            NiceAccountCreationPasswordPage(
              headerData: const NiceAccountCreationLayoutHeaderData(
                title: "Password",
                subTitle: "Please enter your password",
              ),
              passwordDecoration: const InputDecoration(
                hintText: "Password",
              ),
              passwordConfirmationDecoration: const InputDecoration(
                hintText: "Password confirmation",
              ),
            ),
            const NiceAccountCreationContentPage(
              validationStrategy: AccountCreationAlwaysValidValidationStrategy(),
              headerData: NiceAccountCreationLayoutHeaderData(
                title: "Page 6",
              ),
              pageConfig: NiceAccountCreationPageConfig(
                contentAlignment: Alignment.bottomRight,
              ),
              content: Text("Page with content at bottom right!"),
            ),
            const NiceAccountCreationContentPage(
              validationStrategy: AccountCreationAlwaysValidValidationStrategy(),
              headerData: NiceAccountCreationLayoutHeaderData(
                title: "Page 7",
              ),
              content: Text("Final page!"),
            ),
          ],
          onSubmit: () {
            print("Submitted");
          },
        ),
      ),
    );
  }
}
