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
  List<Schedule> _schedules = [];

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
      if (user != null) {
        // List<AppUser> appUsers = this.appUsers;
        for (AppUser r in appUsers) {
          if (r.email == user.email) {
            // assignAppUser(r);
            _appUser = r;
            _loggedIn = true;
            // notifyListeners();
          }
        }
        log('Logged in as database user now set _appUser: ${_appUser.name}');
      } else {
        _loggedIn = false;
      }
      return user;
      // return asda;
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
      log('Set logged in to false');  
    }
      notifyListeners();
  }

  loadData() {
    log('Loading user data');
    FirestoreService.getAppUsers().then((querySnapshot) {
      _appUsers = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (AppUser r in _appUsers) {
        log('Loaded in users loadData(): ${r.name}');
      }
      // setLoggedIn(true);
      // notifyListeners();
    });

    log('Loading schedule data');
    FirestoreService.getSchedules().then((querySnapshot) {
      _schedules = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (Schedule s in _schedules) {
        log('Loaded in schedules loadData(): ${s.id}');
      }
      // setLoggedIn(true);
      // notifyListeners();
    });

  }

  void addSchedule(Schedule schedule) async {
    _schedules.add(schedule); 
    await FirestoreService.addSchedule(schedule);
    log('Adding a schedule in ItemStore and calling Firestore - wth ID of schedule: ${schedule.id}'); 
    notifyListeners();
  }

  void removeSchedule(String scheduleId) async {
    await FirestoreService.deleteSchedule(scheduleId);
    _schedules.remove(scheduleId); 
    log('Ren=moving a schedule in ItemStore and calling Firestore');
    notifyListeners();
  }
}
