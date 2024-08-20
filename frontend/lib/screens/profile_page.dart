import 'package:frontend/app_properties.dart';
import 'package:frontend/screens/details_page.dart';
import 'package:frontend/screens/emergency_contacts_page.dart';
import 'package:frontend/screens/faq_page.dart';
import 'package:frontend/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/temp_details_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/icons/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 8.0, right: 8.0, top: 8.0),
                  child: Text(
                    'Voyage',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Details'),
                  subtitle: Text('Your Personal Details and Medical Info'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DetailsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Emergency Contacts'),
                  subtitle: Text(
                      'Set Emergency Contacts to inform in case of an Emergency'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => EmergencyContactsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Temp Details'),
                  subtitle: Text(
                      'Add Extra Details Temporarily to be sent with the Distress Call'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TempDetailsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: green,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Image.asset('assets/icons/faq.png'),
                  trailing: Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
