import "package:flutter/widgets.dart";

class NiceLayoutUtils {
  static const int TABLET_SIZE = 600;
  static const int DESKTOP_SIZE = 960;

  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < TABLET_SIZE;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= TABLET_SIZE && !isDesktop(context);
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= DESKTOP_SIZE;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isTabletPortrait(BuildContext context) => isTablet(context) && isPortrait(context);

  static bool isTabletLandscape(BuildContext context) => isTablet(context) && isLandscape(context);

  static bool isTabletFromConstraints(BoxConstraints constraints) {
    return constraints.maxWidth >= TABLET_SIZE;
  }
}
