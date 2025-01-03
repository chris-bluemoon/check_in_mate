import 'dart:developer';

import 'package:check_in_mate/screens/settings/sign_up/registger_name.dart';
import 'package:check_in_mate/shared/constants.dart';
import 'package:check_in_mate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({required this.toggleView, super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  bool found = false;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = 'Error: ';
  bool ready = false;

  bool isValidEmail(emailString) {
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailString);
    log('Email valid is $emailValid');
    // return emailValid;
    return emailValid;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return loading ? const Loading() : Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        // centerTitle: true,
        title: const Text('REGISTER'),
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
                  const Text('SIGN IN'),
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
            const Text( 'Enter your email'),
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
                              (val!.isEmpty || !isValidEmail(val.trim())) ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val.trim();
                              if (val.isNotEmpty && isValidEmail(val.trim())) {
                                log(isValidEmail(val.trim()).toString());
                                log('Setting ready to true');
                                ready = true;
                              }
                            });
                          },
                        ),
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
                      child: Text('CONTINUE'),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (ready) Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => (RegisterName(email: email))));
                      }
                      // ready = false;
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
                      child: Text('CONTINUE'),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }
}