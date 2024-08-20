import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';
import 'package:frontend/screens/intro_page.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController guardianController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController medicalConditionsController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Sign Up',
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
              child: Form(
                key: _formKey,
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
                        child:
                            Icon(Icons.person, size: 100, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    // Personal Details
                    Text(
                      'Personal Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(labelText: 'Gender'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    // Contact Details
                    Text(
                      'Contact Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: guardianController,
                      decoration: InputDecoration(labelText: 'Guardian No.'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your guardian\'s phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    // Medical Info
                    Text(
                      'Medical Info',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    TextFormField(
                      controller: bloodTypeController,
                      decoration: InputDecoration(labelText: 'Blood Type'),
                    ),
                    TextFormField(
                      controller: allergiesController,
                      decoration: InputDecoration(labelText: 'Allergies'),
                    ),
                    TextFormField(
                      controller: medicalConditionsController,
                      decoration:
                          InputDecoration(labelText: 'Medical Conditions'),
                    ),
                    SizedBox(height: 24.0),
                    // 4-digit PIN
                    Text(
                      '4-digit PIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    TextFormField(
                      controller: pinController,
                      decoration:
                          InputDecoration(labelText: 'Enter 4-digit PIN'),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your 4-digit PIN';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveDetails();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => IntroPage()),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child:
                                Text('Sign Up', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveDetails() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/details');

      final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      // Encode data
      final data = {
        'name': nameController.text,
        'age': ageController.text,
        'gender': genderController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'guardian': guardianController.text,
        'bloodType': bloodTypeController.text,
        'allergies': allergiesController.text,
        'medicalConditions': medicalConditionsController.text,
        'pin': encrypter.encrypt(pinController.text, iv: iv).base64,
      };
      final encodedData = jsonEncode(data);

      // Write to file
      await file.writeAsString(encodedData);
    } catch (e) {
      print('Error saving details: $e');
    }
  }
}
