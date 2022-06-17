import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterResultPageModel extends Equatable {
  final int number;
  final int size;

  NiceFilterResultPageModel({
    required this.number,
    required this.size,
  });

  NiceFilterResultPageModel.fromJson(Json json)
      : number = json["number"],
        size = json["size"];

  @override
  List<Object?> get props => [number, size];
}
