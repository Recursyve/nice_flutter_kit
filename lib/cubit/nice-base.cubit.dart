import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class BaseCubit<S extends NiceBaseState> extends Cubit<S> {
  BaseCubit(S initialState) : super(initialState);

  @protected
  FutureOr<R?> wrap<R>(FutureOr<R> Function() callback) async {
    try {
      emit(state.copyWithLoadingAndError(loading: true) as S);
      final result = await callback();
      emit(state.copyWithLoadingAndError(loading: false) as S);
      return result;
    } catch (e, s) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(e, s);
      } else {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
      }
      emit(
        state.copyWithLoadingAndError(
          loading: false,
          error: true,
        ) as S,
      );
    }
  }

  @protected
  FutureOr<R?> wrapNoLoading<R>(FutureOr<R> Function() callback) async {
    try {
      return await callback();
    } catch (e, s) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(e, s);
      } else {
        debugPrint(e.toString());
      }
      emit(state.copyWithLoadingAndError(error: true) as S);
    }
  }
}
