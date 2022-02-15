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
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text(
          'First Name: ${contact.name.first}',
          style: text.contactText,
        ),
        Text(
          'Last Name: ${contact.name.last}',
          style: text.contactText,
        ),
        Text(
          'Phone Number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}',
          style: text.contactText,
        ),
        Text(
          'Email Address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}',
          style: text.contactText,
        ),
        ElevatedButton(
          onPressed: () async {
            database
                .update({
                  "p_key": contact.id,
                })
                .then((_) => print("database1 updated"))
                .catchError((error) => print("Error occurred + $error"));
            database1.update({"name": contact.displayName});
          },
          child: const Text("database"),
        )
      ]));
}
