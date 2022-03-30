import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/contactpage.dart';
import 'package:staying_safe/screens/Map_screen.dart';
import "package:flutter/material.dart";
import 'package:staying_safe/screens/auth_screen.dart';
import 'package:staying_safe/screens/sos_screen.dart';
import "package:staying_safe/services/map.dart";
import 'package:staying_safe/contactpage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Mapscreen(),
    SOSscreen(),
    ContactPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // body is the majority of the screen.
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[400],
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: screenHeight * 0.035,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Contacts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
