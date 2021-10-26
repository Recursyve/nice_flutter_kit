import 'package:flutter/cupertino.dart';

class NiceAnimatedFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const NiceAnimatedFadeIn({
    Key? key,
    required this.child,
    required this.duration,
    this.delay: Duration.zero,
  }) : super(key: key);

  @override
  State<NiceAnimatedFadeIn> createState() => _NiceAnimatedFadeInState();
}

class _NiceAnimatedFadeInState extends State<NiceAnimatedFadeIn>
    with SingleTickerProviderStateMixin<NiceAnimatedFadeIn> {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Future.delayed(widget.delay).then((_) {
      if (!mounted) return;

      _animationController.animateTo(1);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.value,
          child: child,
        );
      },
    );
  }
}
