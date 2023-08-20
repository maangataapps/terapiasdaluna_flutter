import 'package:firebase_database/firebase_database.dart';

abstract class EventsRepository {
  void editEvent(FirebaseDatabase firebaseDatabase, String userId, String databaseRef, String idRef, String eventIdRef, Map<String, dynamic> json, Function onFinish);
  Future<void> saveEvent(FirebaseDatabase firebaseDatabase, String databaseRef, String userId, Map<String, dynamic> json, Function onFinish);
  void deleteEvent(FirebaseDatabase firebaseDatabase, String databaseRef, String userId, String idRef, String eventIdRef,);
}