import 'package:check_in_mate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static final refUser = FirebaseFirestore.instance
    .collection('user')
    .withConverter(
      fromFirestore: User.fromFirestore, 
      toFirestore: (User u, _) => u.toFirestore()
  );

  static Future<void> addUser(User user) async {
    await refUser.doc(user.id).set(user);
  }

  static Future<void> updateUser(User user) async {
    await refUser.doc(user.id).update(
      {
        'email': user.email,
        'name': user.name
     }
    );
  }

  static Future<QuerySnapshot<User>> getUsers() {
    return refUser.get();
  }

  
}