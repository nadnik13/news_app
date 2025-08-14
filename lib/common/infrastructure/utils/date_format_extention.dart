import 'package:intl/intl.dart';

extension NewsDateFormat on DateTime {
  String toText({String? pattern}) {
    final String usedPattern = pattern ?? 'dd.MM.yyyy';
    return DateFormat(usedPattern).format(this);
  }
}
