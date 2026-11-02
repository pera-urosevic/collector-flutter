import 'package:collector/models/meta.dart';
import 'package:collector/models/item.dart';
import 'package:collector/models/db.dart';

typedef CollectionName = String;
typedef ListCollectionName = List<CollectionName>;

class Collection {
  final CollectionName name;
  final Meta meta;
  final ItemList items;

  Collection({required this.name, required this.meta, required this.items});

  factory Collection.fromRows(CollectionName name, Rows meta, Rows items) {
    return Collection(name: name, meta: Meta.fromRows(meta), items: items);
  }

  factory Collection.blank(CollectionName name) {
    return Collection(name: name, meta: Meta.blank(), items: []);
  }
}
