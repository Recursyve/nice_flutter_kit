import "package:flutter/material.dart";

class NiceErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRefresh;

  const NiceErrorWidget({
    super.key,
    required this.error,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 250.0,
            ),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          if (onRefresh != null) ...[
            const SizedBox(height: 6),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: onRefresh,
            ),
          ]
        ],
      ),
    );
  }
}
