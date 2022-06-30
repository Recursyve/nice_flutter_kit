enum NiceBaseListMode {
  InfiniteScroll(
    keepPreviousPageValues: true,
    supportsPaginator: false,
    lazyLoaded: true,
  ),
  Paginated(
    keepPreviousPageValues: false,
    supportsPaginator: false,
    lazyLoaded: false,
  );

  final bool keepPreviousPageValues;
  final bool supportsPaginator;
  final bool lazyLoaded;

  const NiceBaseListMode({
    required this.keepPreviousPageValues,
    required this.supportsPaginator,
    required this.lazyLoaded,
  });
}
