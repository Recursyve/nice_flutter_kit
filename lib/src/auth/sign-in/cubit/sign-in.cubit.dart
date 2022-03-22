import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

class NiceSignInCubit<SocialProviders> extends NiceBaseCubit<NiceSignInState> {
  /// Provider that will be used for email/password & social provider sign ins
  final NiceSignInProvider<SocialProviders> signInProvider;
  final NiceAuthCubit authCubit;

  final unsubscribeAll$ = new BehaviorSubject<void>();

  final signInWithPasswordFormGroup = FormGroup({
    "email": FormControl<String>(validators: [Validators.required, Validators.email], value: "foo@bar.dev"),
    "password": FormControl<String>(validators: [Validators.required], value: "123456Ab"),
  });

  NiceSignInCubit({
    required this.signInProvider,
    required this.authCubit,
  }) : super(const NiceSignInState.initialState()) {
    signInWithPasswordFormGroup.valueChanges.takeUntil(unsubscribeAll$).listen((_) => resetInvalidCredentials());
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
