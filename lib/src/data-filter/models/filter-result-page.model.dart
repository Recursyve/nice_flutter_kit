import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

// ignore: must_be_immutable
class NiceFilterResultPageModel extends Equatable {
  final int number;
  final int size;

  const NiceFilterResultPageModel({
    required this.number,
    required this.size,
  });

  NiceFilterResultPageModel.fromJson(Json json)
      : number = json["number"],
        size = json["size"];

  @override
  List<Object> get props => [number, size];
}
