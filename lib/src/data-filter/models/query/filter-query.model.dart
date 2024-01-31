import "package:collection/collection.dart";
import "package:equatable/equatable.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceFilterQueryModel extends NiceBaseFilterQueryModel with EquatableMixin {
  final NiceFilterQueryConditionType condition;
  final List<NiceFilterQueryRuleModel> rules;

  const NiceFilterQueryModel({
    required this.condition,
    required this.rules,
  });

  D? findValueForId<D>(String id) {
    return rules.firstWhereOrNull((rule) => rule.id == id)?.value as D?;
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
