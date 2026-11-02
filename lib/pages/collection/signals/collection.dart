import 'package:collector/models/collection.dart';
import 'package:collector/models/field.dart';
import 'package:collector/models/item.dart';
import 'package:collector/models/meta.dart';
import 'package:collector/models/view.dart';
import 'package:collector/system/platform.dart';
import 'package:signals/signals_flutter.dart';

class CollectionSignal extends Signal<Collection> {
  CollectionSignal(super.value);

  FieldList get fields {
    return value.meta.fields;
  }

  ItemsViewList get views {
    return value.meta.views;
  }

  List<String> get viewsNames {
    return value.meta.views.map((v) => v.name).toList();
  }

  String get imagesPath {
    return '${collectorPath()}/${value.name}';
  }

  ItemList get items {
    return value.items;
  }

  ItemsView view(String viewName) {
    return value.meta.views.firstWhere((v) => v.name == viewName);
  }

  bool itemExists(String fieldName, String fieldValue) {
    return items.any((item) => item[fieldName] == fieldValue);
  }
}

final $collection = CollectionSignal(
  Collection(
    name: '',
    meta: Meta(
      fields: [Field(name: 'id', type: FieldType.id, index: true)],
      views: [ItemsView(name: 'Default')],
    ),
    items: [],
  ),
);

final $fieldsIndex = computed(() {
  return $collection.fields.where((f) => f.index ?? false).toList();
});

final $fieldsImageIndex = computed(() {
  return $fieldsIndex.value.where((f) => f.type == FieldType.image).toList();
});
