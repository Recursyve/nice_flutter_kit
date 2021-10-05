import 'dart:collection';

class NiceFilterResultPageModel {
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
}
