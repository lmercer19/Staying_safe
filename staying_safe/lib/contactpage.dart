import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:staying_safe/styles/styles.dart';
import 'contactlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: const Text(
              'Contacts List',
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
          body: _body()));

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: ListTile(
            title: Text(_contacts![i].displayName,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            onTap: () async {
              final fullContact =
                  await FlutterContacts.getContact(_contacts![i].id);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ContactList(fullContact!)));
            },
          ),
        );
      },
    );
  }

  //   return ListView.builder(
  //     padding: const EdgeInsets.all(25),
  //     itemCount: _contacts!.length,
  //     scrollDirection: Axis.vertical,
  //     itemBuilder: (context, i) => ListTile(
  //       title: Text(
  //         _contacts![i].displayName + '' + '',
  //         style: const TextStyle(color: Colors.white, fontSize: 20),
  //       ),
  //       onTap: () async {
  //         final fullContact =
  //             await FlutterContacts.getContact(_contacts![i].id);
  //         await Navigator.of(context).push(
  //             MaterialPageRoute(builder: (_) => ContactList(fullContact!)));
  //       },
  //     ),
  //   );
  // }
}
