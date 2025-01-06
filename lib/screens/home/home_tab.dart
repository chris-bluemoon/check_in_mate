import 'dart:math';

import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  String _generateRandomTime() {
    final random = Random();
    final hour = random.nextInt(12) + 1;
    final minute = random.nextInt(60);
    final period = random.nextBool() ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final randomTime = _generateRandomTime();
    final width = MediaQuery.of(context).size.width;
    final paddingFraction = width * 0.05;
    final titleFontSize = width * 0.06;
    final timeFontSize = width * 0.12;
    final subtitleFontSize = width * 0.04;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(paddingFraction),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(paddingFraction),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Check In',
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: paddingFraction),
                      Text(
                        randomTime,
                        style: TextStyle(fontSize: timeFontSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: paddingFraction),
                      Text(
                        "Check In Now",
                        style: TextStyle(fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: paddingFraction * 2),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle button press
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Check In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: paddingFraction * 2, vertical: paddingFraction),
                    textStyle: TextStyle(fontSize: subtitleFontSize),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: paddingFraction),
                GestureDetector(
                  onTap: () {
                    // Handle contact support press
                  },
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}