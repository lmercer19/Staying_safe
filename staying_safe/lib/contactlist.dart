import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:staying_safe/styles/styles.dart';

class ContactList extends StatelessWidget {
  final Contact contact;
  final database = FirebaseDatabase.instance.ref("users/");
  final database1 = FirebaseDatabase.instance.ref("users/p_key");
  ContactList(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text(
          contact.displayName,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(children: [
        Text(
          '\n'
          ' First Name: ${contact.name.first}'
          '\n\n'
          ' Last Name: ${contact.name.last}'
          '\n\n'
          ' Phone Number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'
          '\n\n'
          ' Email Address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'
          '\n',
          textAlign: TextAlign.left,
          style: text.contactText,
        ),
        // used to test to see if the data was published to the database.
        // ElevatedButton(
        //   onPressed: () async {
        //     database
        //         .update({
        //           "p_key": contact.id,
        //         })
        //         .then((_) => print("database1 updated"))
        //         .catchError((error) => print("Error occurred + $error"));
        //     database1.update({"name": contact.displayName});
        //   },
        //   child: const Text("database"),
        // )
      ]));
}
