import 'package:nice_flutter_kit/data-filter/models/filter-query-condition.type.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-query-rule.model.dart';

class NiceFilterQueryModel {
  final NiceFilterQueryConditionType condition;

  // List<FilterQueryModel | FilterQueryRuleModel>
  final List<dynamic> rules;

  NiceFilterQueryModel({required this.condition, required this.rules});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": condition.toString(),
        "rules": rules
            .where((rule) => rule is NiceFilterQueryModel || rule is NiceFilterQueryRuleModel)
            .map((rule) => rule?.toJson())
            .toList()
      };
}
