import "package:flutter/src/widgets/framework.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NicePageViewFormAlwaysEnabledStrategy implements NicePageViewFormBaseEnabledStrategy {
  const NicePageViewFormAlwaysEnabledStrategy();

  @override
  bool isEnabled(BuildContext context) => true;
}
