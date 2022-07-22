enum NiceBaseListMode {
  InfiniteScroll(
    keepPreviousValuesOnNextPage: true,
    supportsPaginator: false,
    lazyLoaded: true,
  ),
  Paginated(
    keepPreviousValuesOnNextPage: false,
    supportsPaginator: false,
    lazyLoaded: false,
  );

  final bool keepPreviousValuesOnNextPage;
  final bool supportsPaginator;
  final bool lazyLoaded;

  const NiceBaseListMode({
    required this.keepPreviousValuesOnNextPage,
    required this.supportsPaginator,
    required this.lazyLoaded,
  });
}
