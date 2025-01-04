import 'dart:developer';

import 'package:check_in_mate/screens/activity/activity.dart';
import 'package:check_in_mate/screens/home/check_in.dart';
import 'package:check_in_mate/screens/settings/sign_up/authenticate.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double? screenWidth;
double? screenHeight;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // Fetch database items here
    log('About to call load data from initState of HomePage');
    Provider.of<ItemStore>(context, listen: false).loadData();
    super.initState();
  }

  int _pageIndex = 0;

  bool loggedIn = false;

  final _pages = [
    const CheckIn(),
    const Activity(),
    // const SettingsRoot(),
    const Authenticate(),
    // const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log('Building');
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontSize: width*0.025, color: Colors.black),
        selectedLabelStyle: TextStyle(fontSize: width*0.025, color: Colors.grey),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.home_outlined, size: width*0.05),
            ),
            label: 'CHECK IN',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.menu_book_outlined, size: width*0.05),
            ),
            label: 'ACTIVITY',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.favorite_border, size: width*0.05),
            ),
            label: 'SETTINGS',
          ),
        ],
        // selectedLabelStyle: TextStyle(color: Colors.blue,fontSize: 14),
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(
            () {
              // getCurrentUser();
              _pageIndex = index;
              // bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
              // log('Logged in is set to $loggedIn');
              // if (index == 3 && loggedIn == false) {
              //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const Profile())));
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
              //   _pageIndex = 0;
              // }
            },
          );
        },
      ),
    );
  }
}