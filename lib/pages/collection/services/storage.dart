import 'package:collector/models/collection.dart';
import 'package:collector/models/db.dart';
import 'package:collector/models/item.dart';
import 'package:collector/models/view.dart';
import 'package:collector/pages/collection/services/db.dart';
import 'package:flutter/foundation.dart';

import 'package:sqlite3/sqlite3.dart' as sqlite;

Future<Rows> fetch(sqlite.Database db, String table) async {
  final sqlite.ResultSet results = db.select('SELECT * FROM $table');

  final List<Map<String, dynamic>> itemsList = results.map((row) {
    return Map<String, dynamic>.from(row);
  }).toList();

  return itemsList;
}

Future<Collection> collectionLoad(CollectionName name) async {
  sqlite.Database? db;
  try {
    db = await dbOpen(name);
    if (db == null) {
      throw ('Failed to open database.');
    }
    Rows meta = await fetch(db, 'meta');
    final collection = Collection.fromRows(name, meta, []);
    return collection;
  } catch (e) {
    debugPrint('Error reading database: $e');
    return Collection.blank(name);
  } finally {
    db?.close();
  }
}

class CollectionQueryResult {
  final ItemList items;
  final int total;

  CollectionQueryResult({required this.items, required this.total});
}

Future<CollectionQueryResult> collectionQuery(
  CollectionName name,
  ItemsView view, {
  String search = '',
  List<String> columns = const [],
  int? limit,
  int? skip,
}) async {
  sqlite.Database? db;
  try {
    db = await dbOpen(name);
    if (db == null) {
      throw ('Failed to open database.');
    }

    final searchValue = search.isNotEmpty ? search : view.search;
    final sqlColumns = columns.map((column) => '"${column.replaceAll('"', '')}"').join(' || ');
    final sqlWhere = sqlColumns.isEmpty ? 'WHERE 1 ${view.query}' : 'WHERE ($sqlColumns) LIKE ? ${view.query}';
    final parameters = <Object?>[if (sqlColumns.isNotEmpty) '%$searchValue%'];

    final sqlTotal = 'SELECT COUNT(*) as total FROM "items" $sqlWhere';
    final totalRows = db.select(sqlTotal, parameters);
    final total = totalRows.first['total'] as int;

    final paginated = limit != null || skip != null;
    final sql = 'SELECT * FROM "items" $sqlWhere${paginated ? ' LIMIT ? OFFSET ?' : ''}';
    final itemParameters = <Object?>[...parameters, if (paginated) limit ?? -1, if (paginated) skip ?? 0];

    final results = db.select(sql, itemParameters);
    final items = results.map((row) => Map<String, dynamic>.from(row)).toList();

    return CollectionQueryResult(items: items, total: total);
  } catch (e) {
    debugPrint('Error querying database: $e');
    return CollectionQueryResult(items: [], total: 0);
  } finally {
    db?.close();
  }
}
