import 'package:check_in_mate/screens/home/check_in_card.dart';
import 'package:check_in_mate/shared/my_app_bar.dart';
import 'package:flutter/material.dart';

class CheckIn extends StatelessWidget {
  const CheckIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar('CHECK IN'),
      body: Column(children: [
        const Center(child: CheckInCard()),
        ElevatedButton(
          onPressed: () {}, 
          child: const Text('CHECK IN'))
      ],)
    );
  }
}