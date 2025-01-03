import 'package:flutter/material.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text('Next Check In'),
              SizedBox(height: 20),
              Text('11:00'),
              SizedBox(height: 20),
              Text('Tomorrow'),
              SizedBox(height: 20),
              Text('Check In Between 10:45 AM and 11:30 AM'),
            ],
          ),
        ),
      );
  }
}