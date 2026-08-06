import 'package:collector/system/platform.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

Future<sqlite.Database?> dbOpen(String name) async {
  final path = '${collectorPath()}/$name.db';
  final file = File(path);

  if (!await file.exists()) {
    debugPrint('File does not exist at path: $path');
    return null;
  }

  try {
    final Uint8List fileBytes = await file.readAsBytes();
    final tempDir = await getTemporaryDirectory();
    final tempDbFile = File(p.join(tempDir.path, 'temp_games.db'));
    await tempDbFile.writeAsBytes(fileBytes, flush: true);
    return sqlite.sqlite3.open(tempDbFile.path, mode: sqlite.OpenMode.readOnly);
  } catch (e) {
    debugPrint('Error loading database into memory: $e');
    return null;
  }
}
