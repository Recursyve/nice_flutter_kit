class NiceFilterSearchModel {
  final String? value;

  const NiceFilterSearchModel({required this.value});

  Map<String, dynamic> toJson() => <String, dynamic>{"value": value};
}
