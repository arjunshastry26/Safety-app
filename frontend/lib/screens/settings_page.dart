import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (builder, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Section 1: About the App
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'App Details',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('App Information'),
                        leading: Icon(Icons.info, color: Colors.green[700]),
                        onTap: () => {},
                      ),
                      ListTile(
                        title: Text('Developer Information'),
                        leading: Icon(Icons.code, color: Colors.green[700]),
                        onTap: () => {},
                      ),

                      const SizedBox(height: 20),

                      // Section 2: Privacy & Security
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Privacy & Security',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Privacy & Security'),
                        leading: Icon(Icons.lock, color: Colors.green[700]),
                        onTap: () => {},
                      ),
                      ListTile(
                        title: Text('Acknowledgements'),
                        leading: Icon(Icons.thumb_up, color: Colors.green[700]),
                        onTap: () => {},
                      ),

                      const SizedBox(height: 20),

                      // Section 3: Updates & Reset
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Updates & Reset',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Changelog'),
                        leading: Icon(Icons.history, color: Colors.green[700]),
                        onTap: () => {},
                      ),
                      ListTile(
                        title: Text('Reset SM Pin'),
                        leading: Icon(Icons.refresh, color: Colors.green[700]),
                        onTap: () => {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
