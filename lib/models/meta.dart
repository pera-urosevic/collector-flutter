import 'dart:convert';

import 'package:collector/models/field.dart';
import 'package:collector/models/db.dart';
import 'package:collector/models/view.dart';

class Meta {
  final FieldList fields;
  final ItemsViewList views;

  Meta({required this.fields, this.views = const []});

  factory Meta.fromRows(Rows rows) {
    final fieldsJson = rows.firstWhere((row) => row['key'] == 'fields')['value'];
    final fields = List<Field>.from(jsonDecode(fieldsJson).map((j) => Field.fromRow(j)));

    final viewsJson = rows.firstWhere((row) => row['key'] == 'views')['value'];
    final views = List<ItemsView>.from(jsonDecode(viewsJson).map((j) => ItemsView.fromJson(j)));

    return Meta(fields: fields, views: views);
  }
}
