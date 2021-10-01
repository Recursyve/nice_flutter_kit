class FilterSearchModel {
  final String? value;

  FilterSearchModel({required this.value});

  Map<String, dynamic> toJson() => <String, dynamic>{"value": value};
}
