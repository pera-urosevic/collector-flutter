import 'dart:convert';

import 'package:collector/models/field.dart';
import 'package:collector/models/db.dart';
import 'package:collector/models/view.dart';

class Meta {
  final FieldList fields;
  final ItemsViewList views;
  final Row blank;

  Meta({required this.fields, this.views = const [], this.blank = const <String, dynamic>{}});

  factory Meta.blank() => Meta(fields: []);

  factory Meta.fromRows(Rows rows) {
    final fieldsJson = _value(rows, 'fields');
    final viewsJson = _value(rows, 'views');
    final blankJson = _value(rows, 'blank');

    final fields = fieldsJson == null
        ? <Field>[]
        : List<Field>.from(
            (jsonDecode(fieldsJson) as List).map((j) => Field.fromRow(j as Map<String, dynamic>)),
          );

    final views = viewsJson == null
        ? <ItemsView>[]
        : List<ItemsView>.from(
            (jsonDecode(viewsJson) as List).map((j) => ItemsView.fromJson(j as Map<String, dynamic>)),
          );

    final blank = blankJson == null
        ? <String, dynamic>{}
        : Map<String, dynamic>.from(jsonDecode(blankJson) as Map);

    return Meta(fields: fields, views: views, blank: blank);
  }
}

String? _value(Rows rows, String key) {
  for (final row in rows) {
    if (row['key'] == key) return row['value'] as String?;
  }
  return null;
}
