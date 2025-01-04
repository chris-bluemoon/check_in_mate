import 'dart:developer';

import 'package:check_in_mate/screens/settings/login_screen.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLanding extends StatelessWidget {
  const SettingsLanding({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<ItemStore>(context, listen: false).appUser.name;
    if (userName == 'uneartheduser' || userName == 'CHRIS') {
      log('ADMIN user found');
      // admin = true;
    }
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
        child: Consumer<ItemStore>(builder: (context, value, child) {
          if (Provider.of<ItemStore>(context, listen: false).loggedIn == true) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'PERSONAL (${Provider.of<ItemStore>(context, listen: false).appUser.name})'),
                SizedBox(height: width * 0.04),
                GestureDetector(
                  onTap: () {
                    String userN = Provider.of<ItemStore>(context, listen: false).appUser.name;
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Login'),
              ),
            );
          }
        }),
      ),
    );
  }
}