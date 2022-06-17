enum NiceBaseListMode {
  InfiniteScroll(keepPreviousPageValues: true),
  Paginated(keepPreviousPageValues: false);

  final bool keepPreviousPageValues;

  const NiceBaseListMode({
    required this.keepPreviousPageValues,
  });
}
