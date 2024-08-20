import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';

class EmergencyContactsPage extends StatefulWidget {
  @override
  _EmergencyContactsPageState createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Map<String, String>> emergencyContacts = [];
  late File _contactsFile;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    final directory = await getApplicationDocumentsDirectory();
    _contactsFile = File('${directory.path}/emergency_contacts.json');
    if (_contactsFile.existsSync()) {
      String contactsJson = await _contactsFile.readAsString();
      List<dynamic> decoded = jsonDecode(contactsJson);
      setState(() {
        emergencyContacts = decoded
            .map((contact) => Map<String, String>.from(contact))
            .toList();
      });
    }
  }

  void _saveContacts() async {
    String contactsJson = jsonEncode(emergencyContacts);
    await _contactsFile.writeAsString(contactsJson);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Emergency Contacts',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Emergency Contact Numbers',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'These numbers will be contacted when a distress call is sent out.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: emergencyContacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(emergencyContacts[index]['name'] ?? ''),
                        subtitle: Text(emergencyContacts[index]['phone'] ?? ''),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              emergencyContacts.removeAt(index);
                              _saveContacts();
                            });
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      _showAddContactDialog(context);
                    },
                    child: Text('Add Contact'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    String name = '';
    String phone = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Emergency Contact'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    phone = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  emergencyContacts.add({'name': name, 'phone': phone});
                  _saveContacts();
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
