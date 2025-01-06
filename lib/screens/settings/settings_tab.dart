import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/authenticate');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final paddingFraction = width * 0.05;
    final buttonFontSize = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingFraction),
          child: ElevatedButton(
            onPressed: () => _signOut(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: paddingFraction * 2, vertical: paddingFraction),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Log Out',
              style: TextStyle(fontSize: buttonFontSize),
            ),
          ),
        ),
      ),
    );
  }
}