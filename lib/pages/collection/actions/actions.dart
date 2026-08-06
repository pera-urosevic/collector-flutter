import 'package:collector/models/collection.dart';
import 'package:collector/models/view.dart';
import 'package:collector/pages/collection/services/storage.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:collector/pages/collection/signals/view.dart';
import 'package:collector/signals/busy.dart';
import 'package:signals/signals_flutter.dart';

Future<void> actionLoadCollection(CollectionName name) async {
  $busy.value = true;
  final collection = await collectionLoad(name);
  batch(() {
    $collection.value = collection;
    $query.value = collection.meta.views[0];
  });
  $busy.value = false;
}

Future<void> actionQueryCollection(ItemsView q) async {
  $query.value = q;
}
