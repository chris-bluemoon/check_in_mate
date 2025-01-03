import 'package:check_in_mate/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static final refAppUser = FirebaseFirestore.instance
    .collection('appUser')
    .withConverter(
      fromFirestore: AppUser.fromFirestore, 
      toFirestore: (AppUser u, _) => u.toFirestore()
  );

  static Future<void> addAppUser(AppUser user) async {
    await refAppUser.doc(user.id).set(user);
  }

  static Future<void> updateAppUser(AppUser user) async {
    await refAppUser.doc(user.id).update(
      {
        'email': user.email,
        'name': user.name
     }
    );
  }

  static Future<QuerySnapshot<AppUser>> getAppUsers() {
    return refAppUser.get();
  }

  
}