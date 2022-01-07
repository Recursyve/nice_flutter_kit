import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListHeader extends StatelessWidget {
  final Widget title;
  final VoidCallback? onBack;
  final ValueChanged<String> onSearchChange;
  final Widget? action;

  const NiceBaseListHeader({
    required this.title,
    required this.onBack,
    required this.onSearchChange,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    if (NiceLayoutUtils.isPhone(context) || NiceLayoutUtils.isTabletPortrait(context)) {
      return _buildSmall();
    }

    return _buildLarge();
  }

  Widget _buildSmall() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearch(),
        if (action != null) ...[
          const SizedBox(height: 12),
          action!,
        ],
      ],
    );
  }

  Widget _buildLarge() {
    if (action != null)
      return Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildTitle(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: _buildSearch(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: action!,
            ),
          ),
        ],
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(),
        _buildSearch(),
      ],
    );
  }

  Widget _buildTitle() {
    return Builder(
      builder: (context) => Row(
        children: [
          if (onBack != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.longArrowLeft),
                onPressed: onBack,
              ),
            ),
          title,
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Builder(
      builder: (context) => TextField(
        onChanged: onSearchChange,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: NiceLocalizations.of(context).translate("general.search"),
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
        ),
      ),
    );
  }
}
