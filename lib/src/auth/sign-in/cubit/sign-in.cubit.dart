import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";
import "package:rxdart/rxdart.dart";

class NiceSignInCubit<SocialProviders> extends NiceBaseCubit<NiceSignInState> {
  /// Provider that will be used for email/password & social provider sign ins
  final NiceSignInProvider<SocialProviders> signInProvider;
  final NiceAuthCubit authCubit;
  final NiceSignInConfig config;

  final unsubscribeAll$ = BehaviorSubject<void>();

  final signInWithPasswordFormGroup = FormGroup({
    "email": FormControl<String>(validators: [Validators.required, Validators.email]),
    "password": FormControl<String>(validators: [Validators.required]),
  });

  NiceSignInCubit({
    required this.signInProvider,
    required this.authCubit,
    required this.config,
  }) : super(const NiceSignInState.initialState()) {
    signInWithPasswordFormGroup.valueChanges.takeUntil(unsubscribeAll$).listen((_) => resetInvalidCredentials());

    if (config.signInEmailFieldValidators != null) {
      signInWithPasswordFormGroup.controls["email"]?.setValidators(config.signInEmailFieldValidators!);
    }
  }

  static NiceSignInCubit<SocialProviders> of<SocialProviders>(BuildContext context) =>
      BlocProvider.of<NiceSignInCubit<SocialProviders>>(context);

  @override
  Future<void> close() async {
    unsubscribeAll$.add(null);
    await unsubscribeAll$.close();
    signInWithPasswordFormGroup.dispose();
    return super.close();
  }

  void resetInvalidCredentials() => emit(state.copyWith(invalidCredentials: false));

  Future<void> signInWithPassword() async {
    resetInvalidCredentials();

    await wrap(
      callback: () async {
        if (!signInWithPasswordFormGroup.valid) {
          signInWithPasswordFormGroup.markAllAsTouched();
          return;
        }

        final formValue = signInWithPasswordFormGroup.value;
        final success = await signInProvider.signInWithPassword(
          formValue["email"] as String,
          formValue["password"] as String,
        );

        if (!success) {
          emit(state.copyWith(invalidCredentials: true));
          return;
        }

        if (config.autofillEmailAndPassword) {
          TextInput.finishAutofillContext();
        }

        await authCubit.loadCurrentUser();
      },
    );
  }

  Future<void> signInWithSocialProvider(SocialProviders socialProvider) async {
    resetInvalidCredentials();

    await wrap(
      callback: () async {
        final success = await signInProvider.signInWithSocialProvider(socialProvider);
        if (!success) {
          emit(state.copyWith(invalidCredentials: true));
          return;
        }

        await authCubit.loadCurrentUser();
      },
    );
  }
}
