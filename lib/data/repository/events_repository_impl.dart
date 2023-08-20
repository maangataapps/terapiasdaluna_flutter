import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/repository/events/events_repository.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';

abstract class EventsRepositoryImpl extends EventsRepository {
  @override
  void editEvent(FirebaseDatabase firebaseDatabase, String userId, String databaseRef, String idRef, String eventIdRef, Map<String, dynamic> json, Function onFinish) async {
    var ref = firebaseDatabase.ref('$databaseRef/$userId');
    var query = ref.orderByChild(idRef).equalTo(eventIdRef);
    final event = await query.onValue.first;
    var key = event.snapshot.children.first.key;
    ref.child(key.orEmpty()).set(json,).then((value) => onFinish.call());
  }

  @override
  Future<void> saveEvent(FirebaseDatabase firebaseDatabase, String databaseRef, String userId, Map<String, dynamic> json, Function onFinish) async {
    var ref = firebaseDatabase.ref('$databaseRef/$userId');
    DatabaseReference newEventRef = ref.push();
    await newEventRef.set(
      json,
    ).then((value) => onFinish.call());
  }

  @override
  void deleteEvent(FirebaseDatabase firebaseDatabase, String databaseRef, String userId, String idRef, String eventIdRef,) async {
    var foodEventsRef = firebaseDatabase.ref('$databaseRef/$userId');
    var query = foodEventsRef.orderByChild(idRef).equalTo(eventIdRef);
    final event = await query.onValue.first;
    var key = event.snapshot.children.first.key;
    foodEventsRef.child(key.orEmpty()).remove();
  }
}