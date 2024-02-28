import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterQueryModel extends NiceBaseFilterQueryModel with EquatableMixin {
  final NiceFilterQueryConditionType condition;
  final List<NiceBaseFilterQueryModel> rules;

  const NiceFilterQueryModel({
    required this.condition,
    required this.rules,
  });

  /// Recursively loop through the rules to maybe find a rule with [id]
  D? findValueForId<D>(String id) {
    for (final rule in rules) {
      if (rule is NiceFilterQueryModel) {
        final value = rule.findValueForId(id);
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

  /// Returns a new [NiceFilterQueryModel] with the rule that matches the given [id] removed
  NiceFilterQueryModel copyWithRuleRemoved(String id) {
    return NiceFilterQueryModel(
      condition: condition,
      rules: [
        for (final rule in rules)
          if (rule is NiceFilterQueryModel)
            rule.copyWithRuleRemoved(id)
          else if (rule is NiceFilterQueryRuleModel)
            if (rule.id != id) rule,
      ],
    );
  }

  /// Returns a new [NiceFilterQueryModel] with all the rules removed
  NiceFilterQueryModel copyWithRulesCleared() {
    return NiceFilterQueryModel(
      condition: condition,
      rules: [],
    );
  }

  @override
  Json toJson() => {
        "condition": condition.value,
        "rules": [
          for (final rule in rules) rule.toJson(),
        ],
      };

  @override
  List<Object> get props => [condition, rules];
}
