import 'package:tuple/tuple.dart';

class NiceFutureUtils {
  const NiceFutureUtils._();

  static Future<Tuple2<T1, T2>> wait2<T1, T2>(
    Future<T1> t1,
    Future<T2> t2,
  ) async {
    final result = await Future.wait([t1, t2]);
    return Tuple2<T1, T2>(
      result[0] as T1,
      result[1] as T2,
    );
  }

  static Future<Tuple3<T1, T2, T3>> wait3<T1, T2, T3>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
  ) async {
    final result = await Future.wait([t1, t2, t3]);
    return Tuple3<T1, T2, T3>(
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
    );
  }

  static Future<Tuple4<T1, T2, T3, T4>> wait4<T1, T2, T3, T4>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4]);
    return Tuple4<T1, T2, T3, T4>(
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
    );
  }

  static Future<Tuple5<T1, T2, T3, T4, T5>> wait5<T1, T2, T3, T4, T5>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5]);
    return Tuple5<T1, T2, T3, T4, T5>(
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
      result[4] as T5,
    );
  }

  static Future<Tuple6<T1, T2, T3, T4, T5, T6>> wait6<T1, T2, T3, T4, T5, T6>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
    Future<T5> t6,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5, t6]);
    return Tuple6<T1, T2, T3, T4, T5, T6>(
      result[0] as T1,
      result[1] as T2,
      result[2] as T3,
      result[3] as T4,
      result[4] as T5,
      result[5] as T6,
    );
  }

  static Future<Tuple7<T1, T2, T3, T4, T5, T6, T7>> wait7<T1, T2, T3, T4, T5, T6, T7>(
    Future<T1> t1,
    Future<T2> t2,
    Future<T3> t3,
    Future<T4> t4,
    Future<T5> t5,
    Future<T5> t6,
    Future<T5> t7,
  ) async {
    final result = await Future.wait([t1, t2, t3, t4, t5, t6, t7]);
    return Tuple7<T1, T2, T3, T4, T5, T6, T7>(
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
