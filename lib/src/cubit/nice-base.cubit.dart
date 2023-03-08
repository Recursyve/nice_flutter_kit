import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class NiceBaseCubit<S extends NiceBaseState> extends Cubit<S> {
  NiceBaseCubit(S initialState) : super(initialState);

  @protected
  FutureOr<R?> wrap<R>({
    bool loading = true,
    required FutureOr<R> Function() callback,
    FutureOr<R?> Function(Object e)? onError,
  }) async {
    try {
      if (loading) emit(state.copyWithLoadingAndError(loading: true) as S);
      final result = await callback();
      if (loading) emit(state.copyWithLoadingAndError(loading: false) as S);
      return result;
    } catch (e, s) {
      await NiceConfig.baseCubitConfig?.wrapErrorHandler(e, s);
      emit(
        state.copyWithLoadingAndError(
          loading: loading ? false : state.loading,
          error: true,
        ) as S,
      );
      return await onError?.call(e);
    }
  }
}
