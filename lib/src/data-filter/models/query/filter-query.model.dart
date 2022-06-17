import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/data-filter/models/query/base-filter-query.model.dart';

class NiceFilterQueryModel extends BaseFilterQueryModel with EquatableMixin {
  final NiceFilterQueryConditionType condition;
  final List<BaseFilterQueryModel> rules;

  const NiceFilterQueryModel({
    required this.condition,
    required this.rules,
  });

  // Recursively loop through the rules to maybe find a rule with id
  D? findValueForId<D>(String id) {
    for (final rule in rules) {
      if (rule is NiceFilterQueryModel) {
        final value = rule.findValueForId(id);
        if (value != null) return value;
      } else if (rule is NiceFilterQueryRuleModel) {
        if (rule.id == id) return rule.value;
      }
    }

    return null;
  }

  @override
  Json toJson() => {
        "condition": condition,
        "rules": [
          for (final rule in rules) rule.toJson(),
        ],
      };

  @override
  List<Object> get props => [condition, rules];
}
