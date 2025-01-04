import 'dart:developer';

import 'package:check_in_mate/models/app_user.dart';
import 'package:check_in_mate/screens/settings/sign_up/auth.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:check_in_mate/shared/constants.dart';
import 'package:check_in_mate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool found = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = 'Error: ';

  bool ready = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void handleFoundLogIn(String email) {
      // Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);
      List<AppUser> users =
          Provider.of<ItemStore>(context, listen: false).appUsers;
      found = false;
     
      for (AppUser r in users) {
        if (r.email == email) {
          found = true;
          log('Setting current user');
          setState(() {
            loading = false;
          });
          Provider.of<ItemStore>(context, listen: false).setCurrentUser();
        } 
      }
      if (found == false) {
       
      }
    }

    return loading ? const Loading() : Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        // centerTitle: true,
        title: const Text('SIGN IN'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: width * 0.02),
            child: GestureDetector(
              onTap: () {
                widget.toggleView();
              },
              child: Row(
                children: [
                  const Text('REGISTER'),
                  SizedBox(width: width * 0.01),
                  Icon(Icons.person, size: width * 0.05)
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter your email and password'),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                              ready = true;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                            validator: (val) => val!.length < 6
                                ? 'Enter a password at least 6 chars long'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                                ready = true;
                              });
                            }),
            SizedBox(height: width * 0.05),
            GestureDetector(
              onTap: () async {
                bool res = await _auth.sendPasswordReset(email);
               
                if (res == false) {
                  showAlertDialogError(context);
                }
              },
              child: const Text('Forgotten password?')),
                      ],
                    ))),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (!ready) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('SIGN IN'),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (ready) Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                                       if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                   
                    if (result == null) {
                      setState(() => loading = false);
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
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
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
                                setState(() {
                                  Navigator.pop(context);
                                });
                                // goBack(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                          backgroundColor: Colors.white,
                          title: const Center(
                              child: Text("Error Signing In")),
                        ),
                      );
                              setState(() {
                               
                                if (_formKey.currentState != null) {
                                _formKey.currentState!.reset();
                                }
                              });
                    } else {
                      log(email);
                      handleFoundLogIn(email);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  }
                    ready = false;
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('SIGN IN'),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }
  showAlertDialogError(BuildContext context) {
    // Create button
    double width = MediaQuery.of(context).size.width;

    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(-1.0),
        ),
        side: const BorderSide(width: 0.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: Text("OK")),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: Text('EMAIL NOT FOUND')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please check email'),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('and try again'),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
     showAlertDialog(BuildContext context) {
    // Create button
    double width = MediaQuery.of(context).size.width;

    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(-1.0),
        ),
        side: const BorderSide(width: 0.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: Text("OK")),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: Text('PASSWORD RESET SENT')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Check your registered'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('email to reset password'),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}