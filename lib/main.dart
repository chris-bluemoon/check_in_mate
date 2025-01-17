import 'dart:developer';

import 'package:check_in_mate/screens/home_page.dart';
import 'package:check_in_mate/screens/settings/check_in_schedule.dart';
import 'package:check_in_mate/screens/settings/sign_in_screen.dart';
import 'package:check_in_mate/screens/splash_screen.dart'; // Add this line
import 'package:check_in_mate/services/item_store.dart';
import 'package:check_in_mate/shared/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ItemStore(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      title: 'Check In Mate',
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/': (context) => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            log('snapshot: ${snapshot.hasData}');
            Provider.of<ItemStore>(context, listen: false).loadData();
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const SignInScreen();
            }
          },
        ),
        // '/authenticate': (context) => const Authenticate(),
        '/sign_in_screen': (context) => const SignInScreen(),
        '/splash': (context) => const SplashScreen(),
        '/check_in_schedule': (context) => const CheckInSchedule(),
      },
    );
  }
}