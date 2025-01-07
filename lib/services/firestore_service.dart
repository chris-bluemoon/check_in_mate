import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/models/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static final refAppUsers = FirebaseFirestore.instance
    .collection('appUser')
    .withConverter(
      fromFirestore: AppUser.fromFirestore, 
      toFirestore: (AppUser u, _) => u.toFirestore()
  );

  static final refSchedules = FirebaseFirestore.instance
    .collection('schedule')
    .withConverter(
      fromFirestore: Schedule.fromFirestore, 
      toFirestore: (Schedule u, _) => u.toFirestore()
  );

  static Future<void> addAppUser(AppUser user) async {
    await refAppUsers.doc(user.id).set(user);
  }

  static Future<void> addSchedule(Schedule schedule) async {
    await refSchedules.doc(schedule.id).set(schedule);
  }

  static Future<void> deleteSchedule(String scheduleId) async {
    await refSchedules.doc(scheduleId).delete();
  }

  static Future<QuerySnapshot<Schedule>> getSchedules() {
    return refSchedules.get();
  }

  static Future<void> updateAppUser(AppUser user) async {
    await refAppUsers.doc(user.id).update(
      {
        'email': user.email,
        'name': user.name
     }
    );
  }

  static Future<QuerySnapshot<AppUser>> getAppUsers() {
    return refAppUsers.get();
  }

  
}