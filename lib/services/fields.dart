import 'package:collector/models/field.dart';
import 'package:collector/services/datetime.dart';
import 'package:collector/models/item.dart';

FieldType parseFieldType(String type) {
  switch (type) {
    case 'id':
      return FieldType.id;
    case 'boolean':
      return FieldType.boolean;
    case 'number':
      return FieldType.number;
    case 'string':
      return FieldType.string;
    case 'text':
      return FieldType.text;
    case 'markdown':
      return FieldType.markdown;
    case 'date':
      return FieldType.date;
    case 'datetime':
      return FieldType.datetime;
    case 'select':
      return FieldType.select;
    case 'tags':
      return FieldType.tags;
    case 'image':
      return FieldType.image;
  }
  throw Exception('Unknown field type: $type');
}

String formatFieldName(Field field) {
  return field.name[0].toUpperCase() + field.name.substring(1);
}

String formatFieldValue(Field field, Item item) {
  final value = item[field.name];
  if (value == null) return 'null';
  switch (field.type) {
    case FieldType.boolean:
      return value != 0 ? 'true' : 'false';
    case FieldType.datetime:
      return datetimeFromIso(value);
    default:
      return value.toString();
  }
}

Item cleanupTagsFields(FieldList fields, Item item) {
  for (final field in fields) {
    if (field.type == FieldType.tags) {
      item[field.name] = item[field.name].toSet().toList();
      item[field.name].sort();
    }
  }
  return item;
}
