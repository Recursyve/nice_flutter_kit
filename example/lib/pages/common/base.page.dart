import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class BasePage extends StatelessWidget {
  final String title;
  final Widget child;

  const BasePage({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: GoRouter.of(context).pop,
        ),
      ),
      body: child,
    );
  }
}
