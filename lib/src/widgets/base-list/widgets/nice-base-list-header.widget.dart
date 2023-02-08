import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListHeader extends StatelessWidget {
  final Widget? title;
  final VoidCallback? onBack;
  final Widget? backIcon;
  final ValueChanged<String> onSearchChange;
  final Widget? action;
  final bool hideSearch;

  const NiceBaseListHeader({
    this.title,
    this.backIcon,
    this.onBack,
    this.hideSearch = false,
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
        if (!hideSearch) _buildSearch(),
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
          if (!hideSearch)
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
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildTitle(),
          ),
        ),
        if (!hideSearch)
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildSearch(),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Builder(
      builder: (context) => Row(
        children: [
          if (onBack != null && backIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: backIcon!,
                onPressed: onBack,
              ),
            ),
          if (title != null) title!,
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
