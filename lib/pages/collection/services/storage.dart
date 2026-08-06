import 'package:collector/models/db.dart';
import 'package:collector/pages/collection/services/db.dart';

import 'package:collector/models/collection.dart';
import 'package:flutter/cupertino.dart';

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
    Rows items = await fetch(db, 'items');
    final collection = Collection.fromRows(name, meta, items);
    return collection;
  } catch (e) {
    debugPrint('Error reading database: $e');
    return Collection.blank(name);
  } finally {
    db?.close();
  }
}
