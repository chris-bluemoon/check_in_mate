import 'package:check_in_mate/models/schedule.dart';
import 'package:check_in_mate/services/item_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class CheckInSchedule extends StatefulWidget {
  const CheckInSchedule({super.key});

  @override
  _CheckInScheduleState createState() => _CheckInScheduleState();
}

class _CheckInScheduleState extends State<CheckInSchedule> {
  List<Row> scheduleListView = <Row>[];

  @override
  void initState() {
    super.initState();
    scheduleListView = <Row>[
      Row(
        children: [
          Text(Provider.of<ItemStore>(context, listen: false).schedules[0].time, style: const TextStyle(color: Colors.white),),
          Text(Provider.of<ItemStore>(context, listen: false).schedules[0].id, style: const TextStyle(color: Colors.white),),
          const Expanded(child: SizedBox()),
          const Icon(Icons.delete_outline, color: Colors.white, size: 50),
        ],
      ),
      Row(
        children: [
          Text(Provider.of<ItemStore>(context, listen: false).schedules[1].time, style: const TextStyle(color: Colors.white),),
          const Expanded(child: SizedBox()),
          const Icon(Icons.delete_outline, color: Colors.white, size: 50),
        ],
      ),
    ];
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final paddingFraction = width * 0.05;
    final subtitleFontSize = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: paddingFraction * 2),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(paddingFraction),
          child: Padding(
            padding: EdgeInsets.fromLTRB(paddingFraction, 0, paddingFraction, 0),
            child: Row(
              children: [
                Text('Check In Schedule', style: TextStyle(fontSize: paddingFraction * 1.5)),
              ],
            ),
          ),
      ),), 
      body: Padding(
        padding: EdgeInsets.fromLTRB(paddingFraction, paddingFraction, paddingFraction, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(paddingFraction),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006666),
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: scheduleListView.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Colors.white.withOpacity(0.2));
                      },    
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              setState(() {
                                var scheduleId = Provider.of<ItemStore>(context, listen: false).schedules[index].id;
                                Provider.of<ItemStore>(context, listen: false).removeSchedule(scheduleId);
                                scheduleListView.removeAt(index);
                              });
                              setState(() {});
                            },
                            child: scheduleListView[index],)
                        );
                      },
                    ),
                  ),
                  SizedBox(height: paddingFraction),
                  GestureDetector(
                    onTap: () {
                      scheduleListView.add(const Row(
                        children: [
                          Text('10:00 PM', style: TextStyle(color: Colors.white),),
                          Expanded(child: SizedBox()),
                          Icon(Icons.delete_outline, color: Colors.white, size: 50),
                        ],
                      ));
                      // Provider.of<ItemStore>(context, listen: false).addSchedule(Schedule(id: '0', email: 'dummy', time: '10:00 PM'));      

                      setState(() {
                        User? email = FirebaseAuth.instance.currentUser;
                        Provider.of<ItemStore>(context, listen: false).addSchedule(Schedule(id: uuid.v4(), email: email?.displayName ?? 'default_email', time: '11:00 PM'));
                      });
                    },  
                    child: Text('Add New Schedule', style: TextStyle(color: Colors.white, fontSize: subtitleFontSize))),
            //         TimePickerSpinner(
            //   locale: const Locale('en', ''),
            //   time: dateTime,
            //   is24HourMode: false,
            //   isShowSeconds: false,
            //   itemHeight: 80,
            //   normalTextStyle: const TextStyle(
            //     fontSize: 24,
            //   ),
            //   highlightedTextStyle:
            //       const TextStyle(fontSize: 24, color: Colors.blue),
            //   isForce2Digits: true,
            //   onTimeChange: (time) {
            //     setState(() {
            //       dateTime = time;

            //     });
            //   },
            // )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}