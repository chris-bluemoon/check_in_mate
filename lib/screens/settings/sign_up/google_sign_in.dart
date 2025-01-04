import 'dart:developer';

import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/screens/settings/sign_up/authenticate.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// Join millions of Happy Users
// Rest assured, your data remains secure, and you will not be subjected to any spam!
// Continue with one of these:

var uuid = const Uuid();

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  ValueNotifier userCredential = ValueNotifier('');

  bool showSignIn = true;

  late bool found = false;

  void handleNewLogIn(String email, String name) {
    log('Adding renter if not exists!');
    Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);
    List<AppUser> appUsers = Provider.of<ItemStore>(context, listen: false).appUsers;
    log('Current Provider of renters list is: ${appUsers.toString()}');
    for (AppUser au in appUsers) {
      if (au.email == email) {
        found = true;
        log('User ${au.email} already found, not adding');
        Provider.of<ItemStore>(context, listen: false).setCurrentUser();
        break; // fixed this
      } else {
        found = false;
      }
    }
    if (found == false) {
    log('Adding user to DB for first time');
    String jointUuid = uuid.v4();
    Provider.of<ItemStore>(context, listen: false).addAppUser(AppUser(
      id: jointUuid,
      email: email,
      name: name,
    ));
    // log('Assigning user');
    // // userLoggedIn = true;
    // Provider.of<ItemStore>(context, listen: false).assignUser(AppUser(
    //   id: jointUuid,
    //   email: email,
    //   name: name,
    // ));
    }
  }

  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: 
        AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
          // title: const Text('', style: TextStyle(fontSize: 22, color: Colors.black)),
        body: ValueListenableBuilder(
                valueListenable: userCredential,
                builder: (context, value, child) {
            if (userCredential.value == '' || userCredential.value == null) {
              return Column(
                children: [
                  const Text('Choose a sign in method'),
                  const SizedBox(height: 200),
                  Center(
            child: SizedBox(
              width: width * 0.5,
              child: ElevatedButton.icon(
                                      style: OutlinedButton.styleFrom(
                            textStyle: const TextStyle(color: Colors.white),
                            foregroundColor: Colors.white,//change background color of button
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          side: const BorderSide(width: 1.0, color: Colors.black),
                        ),
                        icon: const Icon(
              Icons.email,
              color: Colors.black,
              size: 30.0,
                        ),
                        label: const Text('Sign in/up with Email'),
                        onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Authenticate()));
                        }),
            )),
                  SizedBox(height: width * 0.05),
                  Center(
            child: SizedBox(
              width: width * 0.5,
              child: ElevatedButton.icon(
                                      style: OutlinedButton.styleFrom(
                            textStyle: const TextStyle(color: Colors.white),
                            foregroundColor: Colors.white,//change background color of button
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          side: const BorderSide(width: 1.0, color: Colors.black),
                        ),
                        icon: Image.asset('assets/logos/google.webp', height: 40),
                        label: const Text('Sign in with Google'),
                      onPressed: () async {
                        showDialogue(context);
                        userCredential.value = await signInWithGoogle();
                        if (userCredential.value != null) {
                          hideProgressDialogue(context);
                          log(userCredential.value.user!.email);
                          log(userCredential.value.user!.displayName);
                          handleNewLogIn(userCredential.value.user!.email,
                              userCredential.value.user!.displayName);
                          // Navigator.pop(context);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              actions: [
                                // ElevatedButton(
                                // onPressed: () {cancelLogOut(context);},
                                // child: const Text('CANCEL', style: TextStyle(color: Colors.black)),),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const WidgetStatePropertyAll<Color>(
                                              Colors.black),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0)),
                                              side: BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Profile()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                              backgroundColor: Colors.white,
                              title: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Flexible(child: Text("Successfully logged in", style: TextStyle(fontSize: 22, color: Colors.black))),
                                  Flexible(
                                      child: Text('Successfully logged in')
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),
              )],
              );
            } else {
              // log('loggin id');
              return const Text('');
              // showSuccessfulLogin();
            }
          },
        ));
  }
}

// showSuccessfulLogin() {

// }
Future<dynamic> signInWithGoogle() async {
  try {
    // Commented out below 2 lines and replaced with profile/email googleAuth, seems to work and no longer getting platform exception
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;
    GoogleSignInAuthentication? googleAuth = await (await GoogleSignIn(
      scopes: ["profile", "email"],
    ).signIn())
        ?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    // TODO
    print('exception->$e');
    log('exception->$e');
  }
}

Future<bool> signOutFromGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } on Exception catch (_) {
    return false;
  }
}

void showDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const Loading(),
  );
}

void hideProgressDialogue(BuildContext context) {
  Navigator.of(context).pop(const Loading());
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitChasingDots(color: Colors.black, size: 50),
      ),
    );
  }
}