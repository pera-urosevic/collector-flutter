import 'package:intl/intl.dart';

final _isoFormat = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
final _datetimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

String? datetimeToIso(String datetime) {
  final dt = _datetimeFormat.tryParseStrict(datetime);
  if (dt == null) return null;
  dt.toUtc();
  return _isoFormat.format(dt);
}

String datetimeFromIso(String value) {
  final dt = DateTime.parse(value);
  return _datetimeFormat.format(dt);
}
