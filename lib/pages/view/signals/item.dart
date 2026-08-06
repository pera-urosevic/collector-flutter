import 'package:collector/models/item.dart';
import 'package:signals/signals_flutter.dart';

class ItemSignal extends Signal<Item> {
  ItemSignal(super.value);

  dynamic val(String field) {
    return value[field];
  }
}

final $item = ItemSignal({});
