import 'dart:developer';

import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/models/schedule.dart';
import 'package:check_in_mate/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemStore extends ChangeNotifier {

  List<AppUser> _appUsers = [];
  AppUser _appUser = AppUser(id: '0000', email: 'dummy', name: 'no_user');
  bool _loggedIn = false;
  final List<Schedule> _schedules = [];

  get appUsers => _appUsers;
  get appUser => _appUser;
  get loggedIn => _loggedIn;
  get schedules => _schedules;

  void addAppUser(AppUser user) async {
    await FirestoreService.addAppUser(user);
    _appUsers.add(user);
    notifyListeners();
  }

  // void assignUser(AppUser user) async {
  //   // await FirestoreService.addItem(item);
  //   _appUser = user;
  //   notifyListeners();
  // }

  Future<dynamic> setCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    for (AppUser r in appUsers) {
      if (user != null && r.email == user.email) {
        _appUser = r;
        // _loggedIn = true;
      } else {
        // _loggedIn = false;
      }
    }
      // return user;
      log('setCurrentUser() user: ${_appUser.email}'); 
      log('Firebase user is: ${user!.email}');
  }

  void setLoggedIn(bool loggedIn) {
    _loggedIn = loggedIn;
    if (loggedIn == true) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      try {
        _appUser = _appUsers.firstWhere((AppUser r) => r.email == user.email);
      } catch (e) {
        log(e.toString());
      }
    } else {
      FirebaseAuth.instance.signOut();
    }
      notifyListeners();
  }

  loadData() {
    if (_appUsers.isNotEmpty) {
      _appUsers.clear();
    } else {
      log('No users to clear, appUsers is empty');
    }
        
    FirestoreService.getAppUsers().then((querySnapshot) {
      _appUsers = querySnapshot.docs.map((doc) => doc.data()).toList();
      User? user = FirebaseAuth.instance.currentUser;
      for (AppUser r in _appUsers) {
        if (user != null && r.email == user.email) {
          log('Assigning _appUser: ${r.email}');
          _appUser = r;
        } 
      }
      // setCurrentUser();
      // setLoggedIn(true);
      // notifyListeners();
    });

    if (_schedules.isNotEmpty) {
      _schedules.clear();
    } else {
      log('No schedules to clear, schedules is empty');
    }
    FirestoreService.getSchedules().then((querySnapshot) {
      List<Schedule> allSchedules = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (Schedule s in allSchedules) {
        if (s.email == _appUser.email) {
          _schedules.add(s);
          log('Loaded in schedules loadData(): ${s.id}');
        }
        // _schedules = querySnapshot.docs.map((doc) => doc.data()).toList();
      }
      // setLoggedIn(true);
      // notifyListeners();
    });

  }

  void addSchedule(Schedule schedule) async {
    _schedules.add(schedule); 
    await FirestoreService.addSchedule(schedule);
    notifyListeners();
  }

  void removeSchedule(String scheduleId) async {
    await FirestoreService.deleteSchedule(scheduleId);
    _schedules.remove(scheduleId); 
    notifyListeners();
  }
}
