import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';

String getEventIdFromDate() => (DateTimeHelper().provideCurrentDate().millisecondsSinceEpoch).toString();

String getReminderIdFromExactTime(int hour, int minute) {
  final dateTimeHelper = DateTimeHelper();
  final properId = dateTimeHelper.provideCurrentDate().copyWith(
    hour: hour,
    minute: minute,
  );
  return '${properId.millisecondsSinceEpoch}';
}