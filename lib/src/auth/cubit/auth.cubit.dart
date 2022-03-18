import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/auth/cubit/auth.state.dart';

class NiceAuthCubit<User extends Object, Account extends Object> extends NiceBaseCubit<NiceAuthState<User, Account>> {
  NiceAuthCubit() : super(const NiceAuthState.initialState());

  factory NiceAuthCubit.of(BuildContext context) => BlocProvider.of(context);
}
