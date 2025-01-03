import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  
  User({required this.id, 
          required this.email, 
          required this.name, 
        }); 

    String id;
    String email;
    String name;

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
    };
  }

  // character from firestore
  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    User user = User(
      id: snapshot.id,
      email: data['email'],
      name: data['name'],
    );

    return user;
  } 
  
  
}