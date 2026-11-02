import 'package:collector/models/view.dart';
import 'package:signals/signals_flutter.dart';

class ViewSignal extends Signal<ItemsView> {
  ViewSignal(super.internalValue);
}

final $query = ViewSignal(ItemsView(name: 'Default'));
