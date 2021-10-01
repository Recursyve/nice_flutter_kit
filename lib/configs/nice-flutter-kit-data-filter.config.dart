class NiceFlutterKitDataFilterConfig {
  final Map<Type, dynamic Function(Map<String, dynamic>)> deserializers;

  const NiceFlutterKitDataFilterConfig({
    this.deserializers: const {},
  });

  bool canDeserialize<T>() => deserializers.containsKey(T);

  T deserialize<T>(Map<String, dynamic> json) {
    if (!canDeserialize<T>()) {
      throw "Unimplemented deserializer function for type ${T.toString()}";
    }

    return deserializers[T]!(json);
  }
}