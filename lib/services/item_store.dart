import 'dart:developer';

import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemStore extends ChangeNotifier {

  final List<AppUser> _appUsers = [];
  AppUser _appUser = AppUser(id: '0000', email: 'dummy', name: 'no_user');
  bool _loggedIn = false;

  get appUsers => _appUsers;
  get appUser => _appUser;
  get loggedIn => _loggedIn;

  void addAppUser(AppUser user) async {
    await FirestoreService.addAppUser(user);
    _appUsers.add(user);
    notifyListeners();
  }

  void assignUser(AppUser user) async {
    // await FirestoreService.addItem(item);
    _appUser = user;
    notifyListeners();
  }

    Future<dynamic> setCurrentUser() async {
      AppUser? user = FirebaseAuth.instance.currentUser as AppUser?;
      if (user != null) {
        List<AppUser> appUsers = this.appUsers;
        for (AppUser r in appUsers) {
          if (r.email == user.email) {
            assignAppUser(r);
            _loggedIn = true;
          }
        }
      } else {
        _loggedIn = false;
      }
      return user;
      // return asda;
    }
    void assignAppUser(AppUser user) async {
    // await FirestoreService.addItem(item);
    _appUser = user;
    notifyListeners();
  }

    void setLoggedIn(bool loggedIn) {
    _loggedIn = loggedIn;
    if (loggedIn == false) {
      log('Setting logged in to true at setLoggedIn function');
      _appUser = AppUser(id: '0000', email: 'dummy', name: 'no_user_set');
      notifyListeners();
    }
  }
}
