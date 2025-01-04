import 'package:check_in_mate/screens/home_page.dart';
import 'package:check_in_mate/screens/settings/login/authentication.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 200),
        Center(child: ElevatedButton(
          onPressed: () {
            AuthenticationHelper().signUp(email: 'a@a.com', password: 'bbbbbb6').then((result) {
        	  if (result == null) {
              Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
              }  else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ));
            }
            });
          },
          child: const Text('Create User'))),
        Center(child: ElevatedButton(
          onPressed: () {
            AuthenticationHelper().signIn(email: 'c@c.com', password: 'bbbbbb6').then((result) {
        	  if (result == null) {
              Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
              }  else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ));
            }
            });
          },
          child: const Text('Sign In'))),
        Center(child: ElevatedButton(
          onPressed: () {
            AuthenticationHelper().signOut().then((result) {
        	  if (result == null) {
              Provider.of<ItemStore>(context, listen: false).setLoggedIn(false);
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
              }  else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ));
            }
            });
          },
          child: const Text('Sign Out'))),
      ],
    );
  }
}
