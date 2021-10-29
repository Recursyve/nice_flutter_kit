import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterQueryUtils {
  // Replace or add the new rule only in the first rules list
  static NiceFilterQueryModel upsertQueryRules(
      NiceFilterQueryModel? query, List<NiceFilterQueryRuleModel> upsertedRules) {
    if (query == null) {
      return NiceFilterQueryModel(condition: NiceFilterQueryConditionType.And, rules: upsertedRules);
    }

    final oldRulesToUpdate = query.rules
        .where((r) => r is NiceFilterQueryRuleModel && upsertedRules.any((nr) => nr.id == r.id))
        .cast<NiceFilterQueryRuleModel>();

    if (oldRulesToUpdate.isEmpty) {
      return NiceFilterQueryModel(
        condition: query.condition,
        rules: [
          ...query.rules,
          ...upsertedRules,
        ],
      );
    }

    final rulesToAdd = upsertedRules.where((nr) => !oldRulesToUpdate.any((or) => or.id == nr.id));

    return NiceFilterQueryModel(
      condition: query.condition,
      rules: [
        for (final rule in query.rules)
          if (rule is NiceFilterQueryRuleModel && oldRulesToUpdate.contains(rule))
            upsertedRules.firstWhere((ur) => ur.id == rule.id)
          else
            rule,
        ...rulesToAdd,
      ],
    );
  }

  static NiceFilterQueryModel removeRuleById(NiceFilterQueryModel? query, String ruleId) {
    if (query == null) {
      return const NiceFilterQueryModel(condition: NiceFilterQueryConditionType.And, rules: []);
    }

    return NiceFilterQueryModel(
      condition: query.condition,
      rules: [
        for (final rule in query.rules)
          if (rule is! NiceFilterQueryRuleModel || rule.id != ruleId) rule
      ],
    );
  }
}
