class ItemsView {
  final String name;
  final String search;
  final String query;

  ItemsView({required this.name, this.search = '', this.query = ''});

  factory ItemsView.fromJson(Map<String, dynamic> json) => ItemsView(
    name: json['name'] ?? '',
    search: json['search'] ?? '',
    query: json['query'] ?? '',
  );

  ItemsView copyWith({String? name, String? search, String? query}) {
    return ItemsView(
      name: name ?? this.name,
      search: search ?? this.search,
      query: query ?? this.query,
    );
  }
}

typedef ItemsViewList = List<ItemsView>;
