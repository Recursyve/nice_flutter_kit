import "package:equatable/equatable.dart";

class NiceFilterSearchModel extends Equatable {
  final String? value;

  const NiceFilterSearchModel({required this.value});

  Map<String, dynamic> toJson() => <String, dynamic>{"value": value};

  @override
  List<Object?> get props => [value];
}
