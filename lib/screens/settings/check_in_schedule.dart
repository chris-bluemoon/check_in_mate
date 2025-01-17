import 'package:check_in_mate/models/schedule.dart';
import 'package:check_in_mate/services/item_store.dart';
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

  List<Schedule> scheduleListView = [];
  
  @override
  void initState() {
    scheduleListView = Provider.of<ItemStore>(context, listen: false).schedules; 
    super.initState();
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
                            child: Text(scheduleListView[index].time,)
                          )
                        );
                      },
                    ),
                  ),
                  SizedBox(height: paddingFraction),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        String email = Provider.of<ItemStore>(context, listen: false).appUser.email;
                        String UUID = uuid.v4();
                        Provider.of<ItemStore>(context, listen: false).addSchedule(Schedule(id: UUID, email: email, time: '11:00 PM'));
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