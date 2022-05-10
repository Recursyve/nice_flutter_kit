import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

/// Similar to [RadioExpandable], but displays the [header] and [body] in a cord.
/// It also handles the tap to expand / collapse the expandable
class RadioExpandableCard extends StatefulWidget {
  /// Decoration that will be displayed underneath this entire widget
  final BoxDecoration? cardDecoration;

  /// Padding that will be displayed around the content of the card, inside [cardDecoration]
  final EdgeInsets? cardPadding;

  /// Margin that will be placed around [cardDecoration]
  final EdgeInsets? cardMargin;

  /// Widget that will be displayed when the expandable in collapsed
  final Widget header;

  /// Padding that will be placed around [header]
  /// This padding will be displayed inside [headerDecoration], if provided
  final EdgeInsets? headerPadding;

  /// Alignment of the [header]
  final Alignment? headerAlignment;

  /// Decoration that will be underneath the [header]
  final BoxDecoration? headerDecoration;

  /// Margin that will be placed around [header]
  /// This margin will be displayed outside [headerDecoration], if provided. Otherwise it will be around [header]
  final EdgeInsets? headerMargin;

  /// Widget that will be displayed when the expandable in expanded
  final Widget body;

  /// Padding that will be placed around [body]
  final EdgeInsets? bodyPadding;

  /// Alignment of the [body]
  final Alignment? bodyAlignment;

  /// Decoration that will be underneath the [body]
  final BoxDecoration? bodyDecoration;

  /// Margin that will be placed around [body]
  /// This margin will be displayed outside [bodyDecoration], if provided. Otherwise, it will be around [body]
  final EdgeInsets? bodyMargin;

  /// Widget that will be displayed between [header] and [header] when the expandable in expanded
  final Widget? separator;

  /// Theme data that will be provided to [Expandable]
  /// The UI properties of the theme will be ignored
  final ExpandableThemeData? theme;

  /// Called whenever the expandable expands (true) or collapses (false).
  final ValueChanged<bool>? onChanged;

  const RadioExpandableCard({
    // Key is required since this is what is used to keep track of which RadioExpandable is expanded
    required Key key,
    this.cardDecoration,
    this.cardPadding,
    this.cardMargin,
    required this.header,
    this.headerPadding,
    this.headerAlignment,
    this.headerDecoration,
    this.headerMargin,
    required this.body,
    this.bodyPadding,
    this.bodyAlignment,
    this.bodyDecoration,
    this.bodyMargin,
    this.separator,
    this.theme,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RadioExpandableCard> createState() => _RadioExpandableCardState();
}

class _RadioExpandableCardState extends State<RadioExpandableCard> {
  final _controller = ExpandableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = _buildRadioExpandable();

    if (widget.cardPadding != null) {
      card = Padding(
        padding: widget.cardPadding!,
        child: card,
      );
    }

    if (widget.cardDecoration != null) {
      card = DecoratedBox(
        decoration: widget.cardDecoration!,
        child: card,
      );
    }

    if (widget.cardMargin != null) {
      card = Padding(
        padding: widget.cardMargin!,
        child: card,
      );
    }

    return card;
  }

  Widget _buildRadioExpandable() {
    return RadioExpandable(
      key: widget.key!,
      controller: _controller,
      onChanged: widget.onChanged,
      header: _buildHeader(),
      body: _buildBody(),
      expandedBuilder: (_, header, body) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          if (widget.separator != null) widget.separator!,
          body,
        ],
      ),
      theme: widget.theme,
    );
  }

  Widget _buildHeader() {
    Widget header = widget.header;
    if (widget.headerPadding != null) {
      header = Padding(
        padding: widget.headerPadding!,
        child: header,
      );
    }

    if (widget.headerAlignment != null) {
      header = Align(
        alignment: widget.headerAlignment!,
        child: header,
      );
    }

    if (widget.headerDecoration != null) {
      header = DecoratedBox(
        decoration: widget.headerDecoration!,
        child: header,
      );
    }

    header = Material(
      borderRadius: widget.headerDecoration?.borderRadius?.resolve(TextDirection.ltr),
      color: widget.headerDecoration?.color ?? Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: InkWell(
          borderRadius: widget.headerDecoration?.borderRadius?.resolve(TextDirection.ltr),
          onTap: () => RadioExpandableProvider.of(context).setExpandedKey(_controller.expanded ? null : widget.key),
          child: header,
        ),
      ),
    );

    if (widget.headerMargin != null) {
      header = Padding(
        padding: widget.headerMargin!,
        child: header,
      );
    }

    return header;
  }

  Widget _buildBody() {
    Widget body = widget.body;
    if (widget.bodyPadding != null) {
      body = Padding(
        padding: widget.bodyPadding!,
        child: body,
      );
    }

    if (widget.bodyAlignment != null) {
      body = Align(
        alignment: widget.bodyAlignment!,
        child: body,
      );
    }

    if (widget.bodyDecoration != null) {
      body = DecoratedBox(
        decoration: widget.bodyDecoration!,
        child: body,
      );
    }

    if (widget.bodyMargin != null) {
      body = Padding(
        padding: widget.bodyMargin!,
        child: body,
      );
    }

    return body;
  }
}
