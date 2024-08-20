import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Details & Medical Info',
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
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: Icon(Icons.person, size: 100, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Text('Name: ABC'),
                  ),
                  ListTile(
                    title: Text('Age: 30'),
                  ),
                  ListTile(
                    title: Text('Gender: Male'),
                  ),
                  ListTile(
                    title: Text('Address: XYZ Area, City'),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Contact Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Text('Phone: +1234567890'),
                  ),
                  ListTile(
                    title: Text('Email: abc@example.com'),
                  ),
                  ListTile(
                    title: Text('Guardian No.: +9876543210'),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Medical Info',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  ListTile(
                    title: Text('Blood Type: O+'),
                  ),
                  ListTile(
                    title: Text('Allergies: None'),
                  ),
                  ListTile(
                    title: Text('Medical Conditions: None'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
