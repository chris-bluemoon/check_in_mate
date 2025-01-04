import 'package:check_in_mate/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(id: user.uid,
      email: 'Anon',
      name: 'anon',
    ) : null;
  }
  // Sign in anon
  Future signInAnon() async {
    try {
      // FirebaseUser user = (await FirebaseAuth.instance.
// signInWithEmailAndPassword(email: email, password: password))
// .user;
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
     
      return null;
    }
  }

  // Register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
     
      return null;
    }
  }

  // Register with email
  Future sendPasswordReset(String email) async {
   
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch(e) {
     
      return false;
    }
  }

  // Sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      return null;
    }

  }


  // Sign out
}