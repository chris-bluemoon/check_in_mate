import 'dart:math';

import 'package:check_in_mate/services/item_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool shareLocationCheckedValue = false;

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
                    color: const Color(0xFF006666),  
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Next Check In',
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: paddingFraction),
                      Text(
                        Provider.of<ItemStore>(context).schedules[1].time.toString(),
                        style: TextStyle(fontSize: timeFontSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: paddingFraction),
                      Text(
                        "Check In Between 10:45 AM and 11:30 AM", 
                        style: TextStyle(fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: paddingFraction * 2),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: SizedBox(
                    height: paddingFraction * 2,
                    width: paddingFraction * 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: const Color(0xFF006666), size: paddingFraction * 1.5),  
                        SizedBox(width: paddingFraction * 0.8),
                        Text('Check In Now', style: TextStyle(color: const Color(0xFF006666), fontSize: subtitleFontSize)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: paddingFraction),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: SizedBox(
                    height: paddingFraction * 2,
                    width: paddingFraction * 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emergency_outlined, color: Colors.white, size: paddingFraction * 1.5),  
                        SizedBox(width: paddingFraction * 0.8),
                        Text('I Need Help!', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: paddingFraction),
                SizedBox(
                  height: paddingFraction * 2,
                  width: paddingFraction * 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: paddingFraction),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("Share Check In Location", style: TextStyle(color: Colors.white),),
                          selected: shareLocationCheckedValue,
                          value: shareLocationCheckedValue,
                          checkboxShape: const CircleBorder(),
                          checkColor: Colors.white,
                          tileColor: const Color(0xFF008080),
                          onChanged: (bool? newValue) {
                            setState(() {
                              shareLocationCheckedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                    ],
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