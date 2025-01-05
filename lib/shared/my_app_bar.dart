
import 'dart:developer';

import 'package:check_in_mate/screens/home_page.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(this.title, {super.key});

  final String title;


  // You also need to override the preferredSize attribute. 
  // You can set it to kToolbarHeight to get the default appBar height.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        Consumer<ItemStore>(builder: (context, value, child) {
          if (Provider.of<ItemStore>(context, listen: false).loggedIn) {
            log('Logged in, showing exit icon');
            return IconButton(
              icon: const Icon(Icons.logout),
                onPressed: () {
                  Provider.of<ItemStore>(context, listen: false).setLoggedIn(false);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
          );} else {
            log('NOT LOGGED IN!');
            return Container(); 
          }
        }),
      ],
      );
  }
}