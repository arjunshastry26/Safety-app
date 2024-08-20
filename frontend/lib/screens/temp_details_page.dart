import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';

class TempDetailsPage extends StatefulWidget {
  @override
  _TempDetailsPageState createState() => _TempDetailsPageState();
}

class _TempDetailsPageState extends State<TempDetailsPage> {
  List<Map<String, String>> tempDetails = [];

  late File _tempDetailsFile;

  @override
  void initState() {
    super.initState();
    _loadTempDetails();
  }

  void _loadTempDetails() async {
    final directory = await getApplicationDocumentsDirectory();
    _tempDetailsFile = File('${directory.path}/temp_details.json');
    if (_tempDetailsFile.existsSync()) {
      String tempDetailsJson = await _tempDetailsFile.readAsString();
      List<dynamic> decoded = jsonDecode(tempDetailsJson);
      setState(() {
        tempDetails =
            decoded.map((detail) => Map<String, String>.from(detail)).toList();
      });
    }
  }

  void _saveTempDetails() async {
    String tempDetailsJson = jsonEncode(tempDetails);
    await _tempDetailsFile.writeAsString(tempDetailsJson);
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
            'Temporary Details',
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
                    'Temporary Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'These details are sent along with your information in the distress call. Any details can prove life-saving. Make sure to remove them once complete.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tempDetails.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tempDetails[index]['title'] ?? ''),
                        subtitle: Text(tempDetails[index]['description'] ?? ''),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              tempDetails.removeAt(index);
                              _saveTempDetails(); // Save changes when deleting
                            });
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      _showAddDetailsDialog(context);
                    },
                    child: Text('Add Details'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDetailsDialog(BuildContext context) {
    String title = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Temporary Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                  onChanged: (value) {
                    description = value;
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
                  tempDetails.add({'title': title, 'description': description});
                  _saveTempDetails(); // Save details when adding
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
