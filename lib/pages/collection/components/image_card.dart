import 'dart:async';
import 'dart:io';

import 'package:collector/models/field.dart';
import 'package:collector/services/fields.dart';
import 'package:collector/models/item.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  final List<Field> fields;
  final Item item;
  final double height;
  final String imagesPath;
  final void Function(Item item) onItem;

  const ImageCard({
    super.key,
    required this.fields,
    required this.item,
    required this.height,
    required this.imagesPath,
    required this.onItem,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool _isHovering = false;
  Timer? _animationTimer;
  final _scrollController = ScrollController();

  void onHover(bool hover) {
    if (hover) {
      _animationTimer = Timer(const Duration(milliseconds: 1000), () {
        _scrollController.jumpTo(0);
        setState(() => _isHovering = true);
      });
    } else {
      _animationTimer?.cancel();
      setState(() => _isHovering = false);
    }
  }

  Widget renderImage(String? value) {
    if (value == null) return Placeholder();
    final file = File('${widget.imagesPath}/$value');
    if (!file.existsSync()) return Placeholder();
    return Image.file(file, fit: BoxFit.cover, alignment: AlignmentGeometry.center);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double overlayHeight = _isHovering ? widget.height : 28;

    final imageField = $fieldsImageIndex.value[0];

    return InkWell(
      onHover: onHover,
      onTap: () => widget.onItem(widget.item),
      child: Card(
        child: Stack(
          alignment: AlignmentGeometry.center,
          fit: StackFit.expand,
          children: [
            renderImage(widget.item[imageField.name]),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                height: overlayHeight,
                color: Colors.black.withValues(alpha: 0.8),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 4),
                    child: Wrap(
                      spacing: double.infinity,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.center,
                      children: List.from(
                        widget.fields
                            .where((field) => field.type != FieldType.image)
                            .map(
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
            ),
          ],
        ),
      ),
    );
  }
}
