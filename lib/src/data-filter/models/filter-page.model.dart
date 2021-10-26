import 'package:equatable/equatable.dart';

class NiceFilterPageModel extends Equatable {
  final int number;
  final int size;

  const NiceFilterPageModel({required this.number, required this.size});

  Map<String, dynamic> toJson() => <String, dynamic>{"number": number, "size": size};

  @override
  List<Object> get props => [number, size];
}
