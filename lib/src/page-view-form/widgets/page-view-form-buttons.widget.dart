import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NicePageViewFormButtons extends StatelessWidget {
  /// Index of the current page in the [PageView]
  final int currentPageIndex;

  /// Number of pages in the [PageView]
  final int pageCount;

  /// Called whenever the next button is pressed
  final VoidCallback onNext;

  /// Called whenever the previous button is pressed and [currentPageIndex]
  final VoidCallback onPrevious;

  /// Called whenever onNext or onPrevious is called
  final VoidCallback? onChange;

  const NicePageViewFormButtons({
    required this.currentPageIndex,
    required this.pageCount,
    required this.onNext,
    required this.onPrevious,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNextButton(),
        _buildPreviousButton(),
      ],
    );

    if (NicePageViewFormConfig
        .of(context)
        .hideButtonsIfKeyboardVisible) {
      return KeyboardVisibilityBuilder(
        builder: (context, keyboardVisible) =>
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              reverseDuration: Duration.zero,
              child: keyboardVisible ? const SizedBox.shrink() : buttons,
            ),
      );
    }

    return buttons;
  }

  Widget _buildNextButton() {
    return Builder(
      builder: (context) {
        final config = NicePageViewFormConfig
            .of(context)
            .nextButtonConfig;

        return _buildButton(
          config: config,
          child: currentPageIndex == pageCount - 1 ? _buildSubmitButton() : Text(config.text),
          onPressed: onNext,
        );
      },
    );
  }

  Widget _buildPreviousButton() {
    return Builder(
      builder: (context) {
        final config = NicePageViewFormConfig
            .of(context)
            .previousButtonConfig;

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
    required NicePageViewFormBaseButtonConfig config,
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

  Widget _buildSubmitButton() {
    return Builder(
        builder: (context) {
          final config = NicePageViewFormConfig
              .of(context)
              .nextButtonConfig;
          if (config.submitButtonContentWidget != null) {
            return config.submitButtonContentWidget!;
          } else {
            return Text(config.submitText);
          }
        }
    );
  }
}
