import 'dart:math';

import 'package:collector/models/filter.dart';
import 'package:collector/models/view.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ViewSignal extends Signal<ItemsView> {
  ViewSignal(super.internalValue);

  String get searchLower => value.search.toLowerCase();

  FilterList get filtersLower => value.filters
      .map((filter) => Filter(field: filter.field, op: filter.op, value: filter.value.toLowerCase()))
      .toList();
}

final $query = ViewSignal(
  ItemsView(name: 'Default', sort: 'created', reverse: true, search: '', filters: FilterList.empty()),
);

final $itemsFound = computed(() {
  final random = Random();

  final itemsFiltered = $collection.items.where((item) {
    return $query.value.filters.every((filter) {
      switch (filter.op) {
        case '~':
          return item[filter.field].toString().toLowerCase().contains(filter.value.toLowerCase());
        case '~*':
          return item[filter.field].toString().toLowerCase().startsWith(filter.value.toLowerCase());
        case '*~':
          return item[filter.field].toString().toLowerCase().endsWith(filter.value.toLowerCase());
        case '=':
          return item[filter.field] == filter.value;
        case '!=':
          return item[filter.field] != filter.value;
        case '>':
          return item[filter.field] > filter.value;
        case '<':
          return item[filter.field] > filter.value;
        default:
          debugPrint('Unknown filter operator: ${filter.op}');
          return true;
      }
    });
  });

  final itemsSearched = itemsFiltered.where((item) {
    return $collection.fields.any(
      (field) => item[field.name].toString().toLowerCase().contains($query.value.search.toLowerCase()),
    );
  });

  final itemsSorted = itemsSearched.toList();
  itemsSorted.sort((a, b) {
    if ($query.value.sort == '') {
      return random.nextInt(2) - 1;
    }
    final sortField = $collection.fields.firstWhere((field) => field.name == $query.value.sort);
    final aValue = a[sortField.name];
    final bValue = b[sortField.name];
    return aValue.compareTo(bValue);
  });

  final itemsOrdered = $query.value.reverse ? itemsSorted.reversed : itemsSorted;

  final items = itemsOrdered.toList();
  return items;
});
