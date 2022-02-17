// ignore_for_file: unnecessary_new

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staying_safe/screens/settings_screen.dart';
import 'auth_screen.dart';
import 'package:staying_safe/styles/styles.dart';
import 'package:staying_safe/services/icon.dart';

class SOSscreen extends StatefulWidget {
  const SOSscreen({Key? key}) : super(key: key);

  @override
  _SOSscreenState createState() => _SOSscreenState();
}

//for settings and logout buttons.

bool _isVisibleExit = false;
bool _isVisibleTimer = true;
CountDownController _controller = CountDownController();

class _SOSscreenState extends State<SOSscreen> {
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.grey[300],
      title: const Text(
        'SOS',
        style: TextStyle(color: Colors.black),
      ),

      automaticallyImplyLeading: false, //remove backbutton
      centerTitle: true,
      actions: [
        PopupMenuButton<int>(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onSelected: (item) => Methods.onSetting(context, item),
            itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Log Out'),
                  ),
                ])
      ],
    );

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //Center Column contents vertically,
        crossAxisAlignment:
            CrossAxisAlignment.center, //Center Column contents horizontally
        children: [
          //const Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.local_phone,
                  color: Colors.black,
                ),
                label: const Text(
                  'EMERGENCY',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
                style: Styles.sosTopEmergency,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.local_phone,
                  color: Colors.black,
                  size: 30.0,
                ),
                style: Styles.sosTopContact,
                label: const Text('CONTACTS',
                    style: TextStyle(color: Colors.black)),
                onPressed: () {},
              ),
            ],
          ),
          // const Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                CircularCountDownTimer(
                    textStyle: const TextStyle(
                        fontSize: 120.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    width: 370,
                    height: 370,
                    autoStart: false,
                    controller: _controller,
                    duration: 10,
                    strokeWidth: 15,
                    fillColor: Colors.red,
                    ringColor: Colors.green),
                Column(
                  children: [
                    Visibility(
                      visible: _isVisibleTimer,
                      child: ElevatedButton(
                        style: Styles.SOSButton,
                        onPressed: () {
                          setState(() {
                            _isVisibleTimer = false;
                            _isVisibleExit = true;
                            _controller.restart();
                          });
                        },
                        child: const Text(
                          'I FEEL UNSAFE',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ]),

          Visibility(
              visible: _isVisibleExit,
              child: Column(
                children: [
                  ElevatedButton(
                    style: Styles.sosExitButton,
                    onPressed: () {
                      _controller.restart();
                      _controller.pause();
                      setState(() {
                        _isVisibleTimer = true;
                        _isVisibleExit = false;
                      });
                    },
                    child: const Text('EXIT SOS MODE'),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
