import "dart:ui";

import "package:equatable/equatable.dart";

class AppState extends Equatable {
  final Locale? overrideLocale;

  const AppState({
    this.overrideLocale,
  });

  AppState copyWith({
    Locale? overrideLocale,
  }) {
    return AppState(
      overrideLocale: overrideLocale ?? this.overrideLocale,
    );
  }

  @override
  List<Object?> get props => [overrideLocale];
}
