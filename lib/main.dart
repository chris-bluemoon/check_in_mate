import 'package:check_in_mate/screens/home_page.dart';
import 'package:check_in_mate/screens/settings/sign_up/authenticate.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  // Firebase initialize
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "revivals dev project",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ItemStore(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);  
            return const HomePage();
          } else {
            return const Authenticate();
          }
        })
    ),
  ));
}