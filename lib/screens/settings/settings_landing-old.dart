import 'dart:developer';

import 'package:check_in_mate/screens/settings/my_account.dart';
import 'package:check_in_mate/screens/settings/sign_up/google_sign_in.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:check_in_mate/shared/line.dart';
import 'package:check_in_mate/shared/whatsapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

class SettingsLanding extends StatefulWidget {
  const SettingsLanding(this.user, this.signOutFromGoogle, {super.key});

  final User? user;
  final Function() signOutFromGoogle;

  @override
  State<SettingsLanding> createState() => _SettingsLandingState();
}

class _SettingsLandingState extends State<SettingsLanding> {

  Future<void> shareApp() async {
    log('Sharing a link');
    const String appLink = 'https://my google play link';
    const String message = 'Check out my new app $appLink';
    await FlutterShare.share(
        title: 'Share App', text: message, linkUrl: appLink);
  }

  ValueNotifier userCredential = ValueNotifier('');

  cancelLogOut(context) async {
    Navigator.pop(context);
  }

  goBack(context) async {
    bool result = await widget.signOutFromGoogle();
    log('Pressed Exit 1');
    if (result) {
      log('awaited result and signed out');
      userCredential.value = '';
      Provider.of<ItemStore>(context, listen: false).setLoggedIn(false);
      Navigator.pop(context);
      setState(() {});
    }
    log('Pressed Exit 2');
  }
  
  bool admin = false;

  @override
  Widget build(BuildContext context) {
    // List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    String userName = Provider.of<ItemStore>(context, listen: false).appUser.name;
    if (userName == 'uneartheduser' || userName == 'CHRIS') {
      log('ADMIN user found');
      admin = true;
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
                    String userN = Provider.of<ItemStore>(context, listen: false)
                        .appUser
                        .name;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (MyAccount(userN))));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.account_circle_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const Text('MY ACCOUNT'),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    shareApp();
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.group_add_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const Text('REFER A FRIEND'),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    // chatWithUsWhatsApp(context);
                    chatWithUsLine(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.chat_bubble_outline, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const Text('CHAT WITH US'),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      actions: [
                        // ElevatedButton(
                        // onPressed: () {cancelLogOut(context);},
                        // child: const Text('CANCEL', style: TextStyle(color: Colors.black)),),
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              backgroundColor:
                                  const WidgetStatePropertyAll<Color>(
                                      Colors.black),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            setState(() {});
                            goBack(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                      backgroundColor: Colors.white,
                      title: const Center(
                          child: Text('Successfully logged out')),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.exit_to_app, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const Text('SIGN OUT'),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.04),
                Divider(
                  height: width * 0.1,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black,
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (const GoogleSignInScreen())));
              },
              child: Row(
                children: [
                  SizedBox(width: width * 0.01),
                  Icon(Icons.login_outlined, size: width * 0.05),
                  SizedBox(width: width * 0.01),
                  const Text('SIGN IN / CREATE ACCOUNT'),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

// Send a LINE
void chatWithUsLine(BuildContext context) async {
  log('Tapped LINE send');
  try {
    await openLineApp(
      phone: '+65 91682725',
      text: 'Hello Unearthed Support...',
    );
  } on Exception catch (e) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(e.toString()),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}
// Send a Whatsapp
void chatWithUsWhatsApp(BuildContext context) async {
  log('Tapped whatsapp send');
  try {
    await openWhatsApp(
      phone: '+65 91682725',
      text: 'Hello Unearthed Support...',
    );
  } on Exception catch (e) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(e.toString()),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}


