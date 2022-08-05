import 'package:clock_app/enums.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/views/alarm_page.dart';
import 'package:clock_app/views/clock_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clock_app/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color color = const Color(0xFF2D2F41);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.clock) {
                  return const ClockPage();
                } else if (value.menuType == MenuType.alarm) {
                  return const AlarmPage();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return Container(
          color: currentMenuInfo.menuType == value.menuType
              ? const Color(0xFF242634)
              : Colors.transparent,
          width: 100,
          child: TextButton(
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    currentMenuInfo.imageSource,
                    scale: 1.5,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    currentMenuInfo.title,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
