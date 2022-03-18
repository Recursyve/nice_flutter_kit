import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/src/auth/login/cubit/login.cubit.dart';
import 'package:nice_flutter_kit/src/auth/login/login.provider.dart';

class NiceLogin extends StatelessWidget {
  final NiceLoginProvider loginProvider;

  const NiceLogin({
    required this.loginProvider,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NiceLoginCubit>(
      create: (context) => NiceLoginCubit(
        loginProvider: loginProvider,
      ),
    );
  }
}
