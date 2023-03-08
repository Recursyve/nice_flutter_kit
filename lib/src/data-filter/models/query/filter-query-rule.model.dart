import 'package:equatable/equatable.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceFilterQueryRuleModel extends NiceBaseFilterQueryModel with EquatableMixin {
  final String id;
  final NiceFilterQueryRuleOperators operation;

  // ((int | String) | List<int | String>)
  final dynamic value;

  const NiceFilterQueryRuleModel({
    required this.id,
    required this.operation,
    required this.value,
  });

  @override
  Json toJson() => {
        "id": id,
        "operation": operation.value,
        "value": value,
      };

  @override
  List<Object> get props => [id, operation, value];
}
