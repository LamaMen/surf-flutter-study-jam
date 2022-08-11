import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get formatted {
    final now = DateTime.now();
    final format = now.year == year && now.month == month && now.day == day
        ? DateFormat('HH:mm')
        : DateFormat('HH:mm, d MMM');

    return format.format(this);
  }
}
