import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ItemStore extends ChangeNotifier {

  final List<AppUser> _users = [];
  final AppUser _user = AppUser(id: '0000', email: 'dummy', name: 'no_user');

  get users => _users;
  get user => _user;

  void addUser(AppUser user) async {
    await FirestoreService.addAppUser(user);
    _users.add(user);
    notifyListeners();
  }
}
