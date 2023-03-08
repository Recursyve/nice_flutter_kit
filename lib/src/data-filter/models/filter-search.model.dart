import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterSearchModel extends Equatable {
  final String value;

  const NiceFilterSearchModel({
    required this.value,
  });

  Json toJson() => {
        "value": value,
      };

  @override
  List<Object> get props => [value];
}
