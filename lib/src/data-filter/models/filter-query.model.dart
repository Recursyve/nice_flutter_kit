import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterQueryModel extends Equatable {
  final NiceFilterQueryConditionType condition;

  // List<FilterQueryModel | FilterQueryRuleModel>
  final List<dynamic> rules;

  const NiceFilterQueryModel({required this.condition, required this.rules});

  // Recursively loop through the rules to maybe find a rule with id
  D? getValueForId<D>(String id) {
    for (final rule in rules) {
      if (rule is NiceFilterQueryModel) {
        final value = rule.getValueForId(id);
        if (value != null) {
          return value;
        }
      } else if (rule is NiceFilterQueryRuleModel) {
        if (rule.id == id) {
          return rule.value;
        }
      }
    }

    return null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": condition.toString(),
        "rules": rules
            .where((rule) => rule is NiceFilterQueryModel || rule is NiceFilterQueryRuleModel)
            // ignore: avoid_dynamic_calls
            .map((rule) => rule?.toJson())
            .toList()
      };

  @override
  List<Object> get props => [condition, rules];
}
