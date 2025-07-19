import 'package:intl/intl.dart';

String formatDateByDMMMMYYYY(DateTime date) {
  return DateFormat('d MMMM yyyy').format(date);
}
