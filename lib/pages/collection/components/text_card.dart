import 'package:collector/models/field.dart';
import 'package:collector/services/fields.dart';
import 'package:collector/models/item.dart';
import 'package:flutter/material.dart';

class TextCard extends StatefulWidget {
  final List<Field> fields;
  final Item item;
  final double height;
  final void Function(Item item) onItem;

  const TextCard({
    super.key,
    required this.fields,
    required this.item,
    required this.height,
    required this.onItem,
  });

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onItem(widget.item),
      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.zero),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 4),
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: double.infinity,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: List.from(
                widget.fields.map(
                  (field) => Text(
                    formatFieldValue(field, widget.item),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
