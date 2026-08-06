import 'package:collector/models/menu.dart';
import 'package:signals/signals_flutter.dart';

class IndexSignal extends Signal<Index> {
  IndexSignal(super.value);
}

final $index = IndexSignal([]);
