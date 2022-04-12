class RadioExpandableProviderNotFoundException implements Exception {
  @override
  String toString() {
    return '''
    Error: Could not find inherited widget of type RadioExpandableProviderData in context.
    Make sure that `RadioExpandableProvider.of(context)` was called underneath a RadioExpandableProvider.
    ''';
  }
}
