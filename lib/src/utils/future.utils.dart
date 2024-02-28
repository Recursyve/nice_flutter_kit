class NiceFutureUtils {
  const NiceFutureUtils._();

  // We need to take a callback for each future, since dart`s futures aren't lazy, meaning that they will all launch
  // even if we don't await them
  static Future<List<T>> batch<T>(List<Future<T> Function()> futureCallbacks, {required int batchSize}) async {
    final results = <T>[];

    List<Future<T>> futureBatch = [];
    for (int i = 0; i < futureCallbacks.length; i++) {
      futureBatch.add(futureCallbacks[i].call());

      if (futureBatch.length == batchSize || i == futureCallbacks.length - 1) {
        final batchResult = await Future.wait(futureBatch);
        results.addAll(batchResult);
        futureBatch = [];
      }
    }

    return results;
  }

  static Future<(T1, T2)> wait2<T1, T2>(
    Future<T1> t1,
    Future<T2> t2,
  ) async {
    final result = await Future.wait([t1, t2]);
    return (
      result[0] as T1,
      result[1] as T2,
    );
  }

  static Future<(T1, T2, T3)> wait3<T1, T2, T3>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
  ) async {
    final result = await Future.wait([t1, t2, t3]);
    return (
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
    );
  }

  static Future<(T1, T2, T3, T4)> wait4<T1, T2, T3, T4>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4]);
    return (
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
    );
  }

  static Future<(T1, T2, T3, T4, T5)> wait5<T1, T2, T3, T4, T5>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5]);
    return (
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
      result[4] as T5,
    );
  }

  static Future<(T1, T2, T3, T4, T5, T6)> wait6<T1, T2, T3, T4, T5, T6>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
    Future<T5> t6,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5, t6]);
    return (
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
      result[4] as T5,
      result[5] as T6,
    );
  }

  static Future<(T1, T2, T3, T4, T5, T6, T7)> wait7<T1, T2, T3, T4, T5, T6, T7>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
    Future<T5> t6,
    Future<T5> t7,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5, t6, t7]);
    return (
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
      result[4] as T5,
      result[5] as T6,
      result[6] as T7,
    );
  }
}
