class NiceFilterSearchModel {
  final String? value;

  NiceFilterSearchModel({required this.value});

  Map<String, dynamic> toJson() => <String, dynamic>{"value": value};
}
