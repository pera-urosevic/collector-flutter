import 'package:collector/pages/collection/components/image_card.dart';
import 'package:collector/pages/collection/components/text_card.dart';
import 'package:collector/models/item.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

const double maxWidth = 220.0;
const double maxHeight = 220.0;

class Grid extends StatelessWidget {
  final void Function(Item item) onItem;

  const Grid({super.key, required this.onItem});

  @override
  Widget build(BuildContext context) {
    final collection = $collection.watch(context);
    final fields = $fieldsIndex.watch(context);
    final imageFields = $fieldsImageIndex.watch(context);
    final items = collection.items;

    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(10, 0, 10, 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxWidth,
          mainAxisExtent: maxHeight,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (imageFields.isEmpty) {
            return TextCard(fields: fields, item: items[index], height: maxHeight - 8, onItem: onItem);
          }
          final imagesPath = $collection.imagesPath;
          return ImageCard(
            fields: fields,
            item: items[index],
            height: maxHeight - 8,
            onItem: onItem,
            imagesPath: imagesPath,
          );
        },
      ),
    );
  }
}
