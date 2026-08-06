import 'package:collector/models/db.dart';
import 'package:collector/services/fields.dart';

enum FieldType { id, boolean, number, string, text, markdown, date, datetime, select, tags, image }

class Field {
  final String name;
  final FieldType type;
  final bool? index;

  Field({required this.name, required this.type, this.index});

  factory Field.fromRow(Row row) => Field(name: row['name'], type: parseFieldType(row['type']), index: row['index']);
}

typedef FieldList = List<Field>;
