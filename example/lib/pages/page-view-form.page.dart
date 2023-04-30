import "dart:io";

import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

class PageViewFormPage extends StatelessWidget {
  const PageViewFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Page view form",
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
        builder: (context, formGroup, _) => NicePageViewForm(
          config: NicePageViewFormConfig(
            nextButtonText: "Next",
            previousButtonText: "Previous",
            defaultPageConfig: const NicePageViewFormPageConfig(
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
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              pageConstraints: BoxConstraints(
                maxWidth: 350,
              ),
            ),
            buttonConstraints: const BoxConstraints(
              maxWidth: 350,
            ),
            hideButtonsIfKeyboardVisible: Platform.isAndroid || Platform.isIOS,
            nextButtonConfig: NicePageViewFormNextButtonConfig(
              text: "Next",
              submitText: "Create account",
              elevated: true,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            previousButtonConfig: NicePageViewFormPreviousButtonConfig(
              text: "Previous",
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              boundReachedState: NicePageViewFormButtonBoundReachedState.Disabled,
            ),
          ),
          pages: [
            NicePageViewFormPage.content(
              validationStrategy: const PageViewFormAlwaysValidValidationStrategy(),
              headerData: const NicePageViewFormLayoutHeaderData(
                title: "Page 1",
                subTitle: "Subtitle test",
              ),
              content: const Text("This is the first page"),
            ),
            NicePageViewFormPage.content(
              validationStrategy: const PageViewFormAlwaysValidValidationStrategy(),
              headerData: const NicePageViewFormLayoutHeaderData(
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
            NicePageViewFormPage.content(
              enabledStrategy: NicePageViewFormCustomEnabledStrategy(
                callback: (context) => (ReactiveForm.of(context) as FormGroup).control("page3Enabled").value,
              ),
              validationStrategy: const PageViewFormAlwaysValidValidationStrategy(),
              headerData: const NicePageViewFormLayoutHeaderData(
                title: "Page 3",
              ),
              content: const Text("This is page 3"),
            ),
            NicePageViewFormPage.email(
              headerData: const NicePageViewFormLayoutHeaderData(
                title: "Email",
                subTitle: "Please enter your email",
              ),
              pageConfig: const NicePageViewFormPageConfig(contentAlignment: Alignment.center),
              emailDecoration: const InputDecoration(
                hintText: "Email",
              ),
              emailConfirmationDecoration: const InputDecoration(
                hintText: "Email confirmation",
              ),
            ),
            NicePageViewFormPage.password(
              headerData: const NicePageViewFormLayoutHeaderData(
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
            NicePageViewFormPage.content(
              validationStrategy: const PageViewFormAlwaysValidValidationStrategy(),
              headerData: const NicePageViewFormLayoutHeaderData(
                title: "Page 6",
              ),
              pageConfig: const NicePageViewFormPageConfig(
                contentAlignment: Alignment.bottomRight,
              ),
              content: const Text("Page with content at bottom right!"),
            ),
            NicePageViewFormPage.content(
              validationStrategy: const PageViewFormAlwaysValidValidationStrategy(),
              headerData: const NicePageViewFormLayoutHeaderData(
                title: "Page 7",
              ),
              content: const Text("Final page!"),
            ),
          ],
          onSubmit: () {
            // ignore: avoid_print
            print("Submitted");
          },
        ),
      ),
    );
  }
}
