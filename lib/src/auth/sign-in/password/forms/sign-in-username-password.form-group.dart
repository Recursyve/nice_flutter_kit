import "package:flutter/cupertino.dart";
import "package:reactive_forms/reactive_forms.dart";

class NiceSignInUsernamePasswordFormGroup extends FormGroup {
  FormControl<String> get usernameControl => control("username") as FormControl<String>;

  FormControl<String> get passwordControl => control("password") as FormControl<String>;

  NiceSignInUsernamePasswordFormGroup()
      : super({
          "username": FormControl<String>(
            validators: [Validators.required],
          ),
          "password": FormControl<String>(
            validators: [Validators.required],
          ),
        });

  factory NiceSignInUsernamePasswordFormGroup.of(BuildContext context) {
    return ReactiveForm.of(context, listen: false) as NiceSignInUsernamePasswordFormGroup;
  }
}
