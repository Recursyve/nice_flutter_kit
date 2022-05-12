import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class NiceBaseState extends Equatable {
  final bool loading;
  final bool error;

  const NiceBaseState({
    required this.loading,
    required this.error,
  });

  const NiceBaseState.initialState()
      : loading = false,
        error = false;

  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error});

  @override
  List<Object?> get props;
}
