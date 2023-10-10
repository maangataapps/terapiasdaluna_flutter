import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:uuid/uuid.dart';

String getEventIdFromDate() => (DateTimeHelper().provideCurrentDate().millisecondsSinceEpoch).toString();

String getEventId() => const Uuid().v4();