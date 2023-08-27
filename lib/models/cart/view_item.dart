class ViewItem {
  ViewItem({
    required this.id,
    required this.name,
    required this.totalPriceFormatted,
    required this.chosenOptions,
  });

  final int? id;
  final String name;
  final String totalPriceFormatted;
  final Iterable<String> chosenOptions;
}
