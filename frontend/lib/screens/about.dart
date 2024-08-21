import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/utils/utils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstant.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Options List
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                    context,
                    'App Information',
                    Icons.info,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  _buildListTile(
                    context,
                    'Developer Information',
                    Icons.person,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  _buildListTile(
                    context,
                    'Privacy and Security',
                    Icons.lock,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  _buildListTile(
                    context,
                    'Acknowledgements',
                    Icons.star,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  _buildListTile(
                    context,
                    'Changelog',
                    Icons.history,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  _buildListTile(
                    context,
                    'Reset SM PIN',
                    Icons.lock_reset,
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon,
      {required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green[800],
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
