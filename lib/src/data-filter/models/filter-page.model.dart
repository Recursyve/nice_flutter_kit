import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterPageModel extends Equatable {
  final int number;
  final int size;

  const NiceFilterPageModel({
    required this.number,
    required this.size,
  });

  Json toJson() => {
        "number": number,
        "size": size,
      };

  @override
  List<Object> get props => [number, size];
}
