import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum NicePageMode {
  View,
  Edit,
  Saving,
}

extension PageModeExt on NicePageMode {
  bool get isView => this == NicePageMode.View;

  bool get isEdit => this == NicePageMode.Edit;

  bool get isSaving => this == NicePageMode.Saving;
}

@immutable
abstract class NiceBaseState extends Equatable {
  final bool loading;
  final bool error;

  const NiceBaseState(this.loading, this.error);

  const NiceBaseState.initialState()
      : loading = false,
        error = false;

  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error});

  @override
  List<Object?> get props;
}
