enum NiceBaseListMode {
  InfiniteScroll(
    keepPreviousValuesOnPageChange: true,
    supportsPaginator: false,
    lazyLoaded: true,
  ),
  Paginated(
    keepPreviousValuesOnPageChange: false,
    supportsPaginator: true,
    lazyLoaded: false,
  );

  final bool keepPreviousValuesOnPageChange;
  final bool supportsPaginator;
  final bool lazyLoaded;

  const NiceBaseListMode({
    required this.keepPreviousValuesOnPageChange,
    required this.supportsPaginator,
    required this.lazyLoaded,
  });
}
