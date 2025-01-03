import 'package:check_in_mate/screens/settings/sign_up/register.dart';
import 'package:check_in_mate/screens/settings/sign_up/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _Authenticate();
}

class _Authenticate extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
    return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}