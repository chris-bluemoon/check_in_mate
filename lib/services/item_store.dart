import 'package:check_in_mate/models/user.dart';
import 'package:flutter/material.dart';

class ItemStore extends ChangeNotifier {

  final List<User> _users = [];
  final User _user = User(id: '0000', email: 'dummy', name: 'no_user');

  get users => _users;
  get user => _user;


}
