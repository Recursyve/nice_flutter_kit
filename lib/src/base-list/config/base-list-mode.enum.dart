/// Modes available for the base list.
enum NiceBaseListMode {
  /// This mode allows for lazy loaded values / infinite scroll.
  /// A base list using this mode may not use a paginator.
  InfiniteScroll(
    keepPreviousValuesOnPageChange: true,
    supportsPaginator: false,
    lazyLoaded: true,
  ),

  /// This mode is for a classic fixed-length page list.
  /// A base list using this mode may (and should) use a paginator.
  Paginated(
    keepPreviousValuesOnPageChange: false,
    supportsPaginator: true,
    lazyLoaded: false,
  );

  /// Whether to keep the values on next page load.
  final bool keepPreviousValuesOnPageChange;

  /// Whether the mode supports a paginator.
  final bool supportsPaginator;

  /// Whether the mode has lazy laoded values.
  final bool lazyLoaded;

  const NiceBaseListMode({
    required this.keepPreviousValuesOnPageChange,
    required this.supportsPaginator,
    required this.lazyLoaded,
  });
}
