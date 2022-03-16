import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationButtons extends StatelessWidget {
  /// Index of the current page in the [PageView]
  final int currentPageIndex;

  /// Number of pages in the [PageView]
  final int pageCount;

  /// Called whenever the next button is pressed
  final VoidCallback onNext;

  /// Called whenever the previous button is pressed and [currentPageIndex]
  final VoidCallback onPrevious;

  const NiceAccountCreationButtons({
    required this.currentPageIndex,
    required this.pageCount,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNextButton(),
        _buildPreviousButton(),
      ],
    );
  }

  Widget _buildNextButton() {
    return Builder(
      builder: (context) {
        final config = NiceAccountCreationConfig.of(context).nextButtonConfig;

        return _buildButton(
          config: config,
          child: Text(currentPageIndex == pageCount - 1 ? config.submitText : config.text),
          onPressed: onNext,
        );
      },
    );
  }

  Widget _buildPreviousButton() {
    return Builder(
      builder: (context) {
        final config = NiceAccountCreationConfig.of(context).previousButtonConfig;

        final isAtFirstPage = currentPageIndex == 0;
        if (isAtFirstPage && config.boundReachedState.isHidden) {
          return const SizedBox.shrink();
        }

        return _buildButton(
          config: config,
          child: Text(config.text),
          onPressed: isAtFirstPage && config.boundReachedState.isDisabled
              ? null
              : () {
                  if (!isAtFirstPage) onPrevious();
                },
        );
      },
    );
  }

  Widget _buildButton({
    required NiceAccountCreationBaseButtonConfig config,
    required Widget child,
    required VoidCallback? onPressed,
  }) {
    if (config.elevated) {
      return Padding(
        padding: config.padding,
        child: ElevatedButton(
          style: config.style,
          onPressed: onPressed,
          child: child,
        ),
      );
    }

    return Padding(
      padding: config.padding,
      child: TextButton(
        style: config.style,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
