enum NiceBaseListMode {
  InfiniteScroll(
    keepPreviousPageValues: true,
    supportsPaginator: false,
  ),
  Paginated(
    keepPreviousPageValues: false,
    supportsPaginator: false,
  );

  final bool keepPreviousPageValues;
  final bool supportsPaginator;

  const NiceBaseListMode({
    required this.keepPreviousPageValues,
    required this.supportsPaginator,
  });
}
