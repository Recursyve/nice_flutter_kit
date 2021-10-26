import 'dart:collection';

import 'package:equatable/equatable.dart';

class NiceFilterResultPageModel extends Equatable {
  int? number;
  int? size;

  NiceFilterResultPageModel({this.number, this.size});

  NiceFilterResultPageModel.fromJson(LinkedHashMap<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    number = json["number"];
    size = json["size"];
  }

  @override
  List<Object?> get props => [number, size];
}
