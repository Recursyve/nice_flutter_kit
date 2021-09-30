import "dart:collection";

class FilterResultPageModel {
  int? number;
  int? size;

  FilterResultPageModel({this.number, this.size});

  FilterResultPageModel.fromJson(LinkedHashMap<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    number = json["number"];
    size = json["size"];
  }
}
