class Filter {
  final String field;
  final String op;
  final dynamic value;

  Filter({required this.field, required this.op, required this.value});

  factory Filter.fromJson(Map<String, dynamic> json) =>
      Filter(field: json['field'], op: json['op'], value: json['value']);

  Map<String, dynamic> toJson() => {'field': field, 'op': op, 'value': value};
}

typedef FilterList = List<Filter>;

Filter blankFilter = Filter(field: '', op: '=', value: '');

FilterList blankFilters = FilterList.from([]);

Filter copyFilter(Filter filter, {String? field, String? op, dynamic value}) =>
    Filter(field: field ?? filter.field, op: op ?? filter.op, value: value ?? filter.value);
