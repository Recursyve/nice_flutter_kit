import "package:example/cubit/app.state.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void setOverrideLocale(Locale overrideLocale) {
    emit(state.copyWith(overrideLocale: overrideLocale));
  }
}
