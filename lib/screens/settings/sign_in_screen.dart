import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showSignInButton = false;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Provider.of<ItemStore>(context, listen: false).setCurrentUser(_emailController.text);
        // Navigator.of(context).pushReplacementNamed('/');

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final paddingFraction = width * 0.05;
    final inputFontSize = width * 0.04;
    final buttonFontSize = width * 0.045;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(paddingFraction),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: paddingFraction * 6),
                    Image(
                      image: const AssetImage('assets/logo4_no_bg_white.png'),
                      width: width * 0.5,
                    ),
                    SizedBox(height: paddingFraction * 2),
                    SizedBox(
                      width: width * 0.6,
                      child: TextFormField(
                        onChanged: (emailText) {
                          if (_passwordController.text.isNotEmpty && emailText.isNotEmpty) {
                            showSignInButton = true;
                          } else {
                            showSignInButton = false;
                          }     
                        },  
                        controller: _emailController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          label: Center(child: Text('Email')),
                          labelStyle: TextStyle(color: Colors.white),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: inputFontSize),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: paddingFraction),
                    SizedBox(
                      width: width * 0.6,
                      child: TextFormField(
                        onChanged: (pwordText) {
                          log('password changed');
                          if (_emailController.text.isNotEmpty && pwordText.isNotEmpty) {
                            showSignInButton = true;
                          } else {
                            showSignInButton = false;
                          }     
                        },  
                        controller: _passwordController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          label: Center(child: Text('Password')),
                          labelStyle: TextStyle(color: Colors.white),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: inputFontSize),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: paddingFraction * 2),
                    if (showSignInButton) ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(horizontal: paddingFraction * 2, vertical: paddingFraction * 0.5),
                        // minimumSize: const Size(double.infinity, 20),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: buttonFontSize),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initialization() async {
    log('initializing...');
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }
}