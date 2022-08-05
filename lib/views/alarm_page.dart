import 'package:clock_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: alarm.gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: alarm.gradientColors.last.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                alarm.description,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sen',
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: true,
                            onChanged: (bool value) {},
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        'Mon-Fri',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sen',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '07:00 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy([
                if (alarms.length < 5)
                  DottedBorder(
                    strokeWidth: 3,
                    color: Color(0xFFEAECFF),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(24),
                    dashPattern: [5, 4],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF444974),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          scheduleAlarm();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/add_alarm.png',
                                scale: 1.5,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Add Alarm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sen',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  const Text('Only 5 alarms allowed!'),
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    var sheduleNotificationDatetime = DateTime.now().add(Duration(seconds: 10));

    // ignore: prefer_const_constructors
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'icons8_alarme_96',
      sound: const RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: const DrawableResourceAndroidBitmap('icons8_alarme_96'),
    );

    // ignore: prefer_const_constructors
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Office',
        'Good morning! Time for office',
        sheduleNotificationDatetime,
        platformChannelSpecifics);
  }
}
