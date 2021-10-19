import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class NiceBaseCubit<S extends NiceBaseState> extends Cubit<S> {
  NiceBaseCubit(S initialState) : super(initialState);

  @protected
  FutureOr<R?> wrap<R>({
    bool loading: true,
    required FutureOr<R> Function() callback,
  }) async {
    try {
      if (loading) emit(state.copyWithLoadingAndError(loading: true) as S);
      final result = await callback();
      if (loading) emit(state.copyWithLoadingAndError(loading: false) as S);
      return result;
    } catch (e, s) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(e, s);
      } else {
        debugPrint(e.toString());
      }
      emit(
        state.copyWithLoadingAndError(
          loading: loading ? false : state.loading,
          error: true,
        ) as S,
      );
    }
  }
}
