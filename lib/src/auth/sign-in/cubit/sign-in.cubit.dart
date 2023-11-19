import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceSignInCubit extends NiceBaseCubit<NiceSignInState> {
  NiceSignInCubit() : super(const NiceSignInState.initialState());

  factory NiceSignInCubit.of(BuildContext context) => BlocProvider.of(context);

  void clearInvalidCredentials() => emit(state.copyWith(invalidCredentials: false));

  void markInvalidCredentials() => emit(state.copyWith(invalidCredentials: true));

  Future<bool> executeSignInCallback(Future<bool> Function() callback) async {
    if (state.loading) {
      return false;
    }

    try {
      emit(state.copyWith(loading: true, invalidCredentials: false));

      final success = await callback();
      if (!success) {
        markInvalidCredentials();
      }

      return success;
    } catch (e, s) {
      FlutterError.onError?.call(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: "nice_flutter_kit/nice_sign_in",
        ),
      );
      markInvalidCredentials();
      return false;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
