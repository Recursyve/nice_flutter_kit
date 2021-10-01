class FilterPageModel {
  final int number;
  final int size;

  FilterPageModel({required this.number, required this.size});

  Map<String, dynamic> toJson() => <String, dynamic>{"number": number, "size": size};
}
