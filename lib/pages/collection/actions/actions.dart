import 'package:collector/models/collection.dart';
import 'package:collector/models/view.dart';
import 'package:collector/pages/collection/services/storage.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:collector/pages/collection/signals/view.dart';
import 'package:collector/signals/busy.dart';
import 'package:signals/signals_flutter.dart';

int _queryToken = 0;

Future<void> actionLoadCollection(CollectionName name) async {
  $busy.value = true;
  try {
    final collection = await collectionLoad(name);
    final view = collection.meta.views.isNotEmpty ? collection.meta.views.first : ItemsView(name: 'Default');
    batch(() {
      $collection.value = collection;
      $query.value = view;
    });
    await _actionLoadItems();
  } finally {
    $busy.value = false;
  }
}

Future<void> actionQueryCollection(ItemsView view) async {
  $busy.value = true;
  try {
    $query.value = view;
    await _actionLoadItems();
  } finally {
    $busy.value = false;
  }
}

Future<void> _actionLoadItems() async {
  final collection = $collection.value;
  if (collection.name.isEmpty) return;

  final token = ++_queryToken;
  final view = $query.value;
  final columns = collection.meta.fields.where((field) => field.index ?? false).map((field) => field.name).toList();
  final result = await collectionQuery(collection.name, view, search: view.search, columns: columns);

  if (token != _queryToken) return;

  $collection.value = Collection(name: collection.name, meta: collection.meta, items: result.items);
}
