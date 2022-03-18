import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/auth/login/cubit/login.state.dart';
import 'package:nice_flutter_kit/src/auth/login/login.provider.dart';

class NiceLoginCubit extends NiceBaseCubit<NiceLoginState> {
  final NiceLoginProvider loginProvider;

  NiceLoginCubit({
    required this.loginProvider,
  }) : super(const NiceLoginState.initialState());

  factory NiceLoginCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> loginWithPassword(String email, String password) async {
    await wrap(
      callback: () async {
        await loginProvider.loginWithPassword(email, password);
      },
    );
  }
}
