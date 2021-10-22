import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nice_flutter_kit/localizations/nice.localizations.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final TextEditingController searchController;
  final Widget? action;

  const NiceBaseListHeader({
    required this.title,
    required this.onBack,
    required this.searchController,
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Builder(
      builder: (context) => TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white54,
          ),
          hintText: NiceLocalizations.of(context).translate("general.search"),
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
        ),
      ),
    );
  }
}
