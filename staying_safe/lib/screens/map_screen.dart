import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/screens/settings_screen.dart';
import "package:flutter/material.dart";
import 'package:staying_safe/screens/auth_screen.dart';
import "package:staying_safe/services/map.dart";
import 'package:staying_safe/styles/styles.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({Key? key}) : super(key: key);

  @override
  _MapscreenState createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Home',
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
      ),
      // body is the majority of the screen.
      body: const MapWidget(),
    );
  }
}
