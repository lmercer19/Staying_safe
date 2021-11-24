import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/screens/settings_screen.dart';
import "package:flutter/material.dart";
import 'package:staying_safe/screens/auth_screen.dart';
import "package:staying_safe/services/map.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kent Walksafe'),
        automaticallyImplyLeading: false, //remove backbutton
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              icon: const Icon(Icons.menu),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Setting'),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Trusted Contacts',
          ),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const setting()),
        );
        break;
      case 1:
        () async {
          await FirebaseAuth.instance.signOut();
        };
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthApp()),
        );
        break;
    }
  }
}
