import 'package:nice_flutter_kit/data-filter/models/filter-query-rule-operator.type.dart';

class NiceFilterQueryRuleModel {
  final String id;
  final NiceFilterQueryRuleOperatorType operation;

  // ((int | String) | List<int | String>)
  final dynamic value;

  NiceFilterQueryRuleModel({required this.id, required this.operation, required this.value});

  Map<String, dynamic> toJson() => <String, dynamic>{"id": id, "operation": operation.toString(), "value": value};
}
