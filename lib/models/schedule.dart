import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  
  Schedule({required this.id, 
          required this.email, 
          required this.time, 
        }); 

    String id;
    String email;
    String time;

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'time': time,
    };
  }

  // character from firestore
  factory Schedule.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    Schedule schedule = Schedule(
      id: snapshot.id,
      email: data['email'],
      time: data['time'],
    );

    return schedule;
  } 
  
  
}