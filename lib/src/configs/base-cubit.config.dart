import 'dart:async';

import 'package:flutter/foundation.dart';

typedef ErrorCallback = FutureOr<void> Function(Object e, StackTrace s);

class NiceBaseCubitConfig {
  final ErrorCallback wrapErrorHandler;

  static void _defaultWrapErrorHandler(Object e, StackTrace s) {
    debugPrint(e.toString());
  }

  const NiceBaseCubitConfig._({
    required this.wrapErrorHandler,
  });

  factory NiceBaseCubitConfig({
    ErrorCallback? wrapErrorHandler,
  }) {
    return NiceBaseCubitConfig._(
      wrapErrorHandler: wrapErrorHandler ?? _defaultWrapErrorHandler,
    );
  }
}
