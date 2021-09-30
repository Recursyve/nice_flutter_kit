import 'package:nice_flutter_kit/data-filter/models/filter-query-condition.type.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-query-rule.model.dart';

class FilterQueryModel {
  final FilterQueryConditionType condition;

  // List<FilterQueryModel | FilterQueryRuleModel>
  final List<dynamic> rules;

  FilterQueryModel({required this.condition, required this.rules});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": condition.toString(),
        "rules": rules
            .where((rule) => rule is FilterQueryModel || rule is FilterQueryRuleModel)
            .map((rule) => rule?.toJson())
            .toList()
      };
}
