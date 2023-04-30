import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceAuthCubit<User extends Object, Account extends Object> extends NiceBaseCubit<NiceAuthState<User, Account>> {
  /// [NiceAuthProvider] that will be used to handle the current user
  final NiceAuthProvider<User, Account> authProvider;

  NiceAuthCubit({
    required this.authProvider,
  }) : super(NiceAuthState.initialState());

  static NiceAuthCubit<User, Account> of<User extends Object, Account extends Object>(BuildContext context) =>
      BlocProvider.of<NiceAuthCubit<User, Account>>(context);

  Future<void> init() async {
    await loadCurrentUser();
    emit(state.copyWith(initialized: true));
  }

  /// Uses [authProvider] to load the current user, and maybe the account if there is a user
  Future<void> loadCurrentUser() async {
    await wrap(
      callback: () async {
        final user = await authProvider.getCurrentUser();
        if (user == null) {
          emit(state.copyWithUserAndAccount(null, null));
          return;
        }

        final account = await authProvider.getCurrentAccount();

        emit(state.copyWithUserAndAccount(user, account));
      },
    );
  }

  /// Signs out the current user and reset the state
  Future<void> signOut() async {
    await wrap(
      callback: () async {
        await authProvider.signOut();
        emit(state.copyWithUserAndAccount(null, null));
      },
    );
  }
}
