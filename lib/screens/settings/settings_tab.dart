import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/sign_in_screen');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final paddingFraction = width * 0.05;
    final subtitleFontSize = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        leading: const SizedBox(),
        leadingWidth: paddingFraction * 0.5,
        title: Text('Settings', style: TextStyle(fontSize: paddingFraction * 1.5)),
      ),  
      body: Padding(
        padding: EdgeInsets.fromLTRB(paddingFraction, 0, paddingFraction, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(paddingFraction),
                decoration: BoxDecoration(
                  color: const Color(0xFF006666),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/check_in_schedule');
                      },  
                      child: Row(
                        children: [
                          // SizedBox(width: paddingFraction),
                          Text('Check-ins Schedule', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                          const Expanded(child: SizedBox()),
                          const Icon(Icons.chevron_right, color: Colors.white, size: 80),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white.withOpacity(0.2)),
                    Row(
                      children: [
                        // SizedBox(width: paddingFraction),
                        Text('My Relatives', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.chevron_right, color: Colors.white, size: 80),
                      ],
                    ),
                    Divider(color: Colors.white.withOpacity(0.2)),
                    Row(
                      children: [
                        // SizedBox(width: paddingFraction),
                        Text('Notifcations', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.chevron_right, color: Colors.white, size: 80),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingFraction),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(paddingFraction),
                decoration: BoxDecoration(
                  color: const Color(0xFF006666),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // SizedBox(width: paddingFraction),
                        Icon(Icons.help_outline, color: Colors.white, size: paddingFraction * 2),
                        SizedBox(width: paddingFraction),
                        Text('Help Center', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                        // const Expanded(child: SizedBox()),
                        // const Icon(Icons.chevron_right, color: Colors.white, size: 80),
                      ],
                    ),
                    Divider(height: paddingFraction * 0.8, color: Colors.white.withOpacity(0.2)),
                    Row(
                      children: [
                        // SizedBox(width: paddingFraction),
                        Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: paddingFraction * 2),   
                        SizedBox(width: paddingFraction),
                        Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                      ],
                    ),
                    Divider(height: paddingFraction * 0.8, color: Colors.white.withOpacity(0.2)),
                    GestureDetector(
                      onTap: () {
                        _signOut(context);
                      },    
                      child: Row(
                        children: [
                          // SizedBox(width: paddingFraction),
                          Icon(Icons.exit_to_app_outlined, color: Colors.white, size: paddingFraction * 2),  
                          SizedBox(width: paddingFraction),
                          Text('Sign Out', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingFraction),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(paddingFraction),
                decoration: BoxDecoration(
                  color: const Color(0xFF006666),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // SizedBox(width: paddingFraction),
                        Text('Delete Account', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize)),
                        // const Expanded(child: SizedBox()),
                        // const Icon(Icons.chevron_right, color: Colors.white, size: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}