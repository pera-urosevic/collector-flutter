import 'dart:io';

import 'package:collector/services/fields.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:collector/models/field.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:flutter/material.dart';
import 'package:collector/models/item.dart';

Widget? renderFieldView(Field field, Item item) {
  if (item[field.name] == null) return Container();
  switch (field.type) {
    case FieldType.image:
      final value = item[field.name];
      final imagesPath = $collection.imagesPath;
      final file = File('$imagesPath/$value');
      if (!file.existsSync()) return Placeholder(fallbackWidth: 320, fallbackHeight: 320);
      return Tooltip(message: field.name, child: Image.file(file));
    case FieldType.markdown:
      final value = item[field.name];
      return Tooltip(
        message: field.name,
        child: MarkdownBlock(data: value, config: MarkdownConfig.darkConfig),
      );
    case FieldType.id:
    case FieldType.boolean:
    case FieldType.number:
    case FieldType.string:
    case FieldType.date:
    case FieldType.datetime:
    case FieldType.select:
    case FieldType.tags:
      final label = formatFieldName(field);
      final value = formatFieldValue(field, item);
      return value.isNotEmpty ? SelectableText('$label: $value') : null;
    case FieldType.text:
      final label = formatFieldName(field);
      final value = formatFieldValue(field, item);
      return value.isNotEmpty ? SelectableText('$label:\n$value') : null;
  }
}
