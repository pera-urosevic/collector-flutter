import 'package:collector/models/filter.dart';

class ItemsView {
  final String name;
  final String sort;
  final bool reverse;
  final String search;
  final List<Filter> filters;

  ItemsView({required this.name, required this.sort, required this.reverse, this.search = '', this.filters = const []});

  factory ItemsView.fromJson(Map<String, dynamic> json) => ItemsView(
    name: json['name'],
    sort: json['sort'],
    reverse: json['reverse'],
    search: json['search'],
    filters: (json['filters'] as List).map((f) => Filter.fromJson(f)).toList(),
  );
}

typedef ItemsViewList = List<ItemsView>;
