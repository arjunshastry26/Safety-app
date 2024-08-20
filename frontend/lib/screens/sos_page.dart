import 'package:flutter/material.dart';
import 'package:frontend/app_properties.dart';

class SOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
          color: darkGrey,
        ),
        title: Text(
          'SOS',
          style: TextStyle(
            color: darkGrey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            _buildProductItem(
              context,
              'assets/icons/emergency_basic.png',
              'Basic Mode',
              '💠 Share Live Location \n💠 Detect Screams \n💠 Inform Emergency Contacts',
              onTap: () {
                // Handle tracking the product
              },
              buttonText: 'Activate',
            ),
            _buildProductItem(
              context,
              'assets/icons/emergency.png',
              'Danger Mode',
              '💠 Share Live Location \n💠 Detect Screams \n💠 Inform Emergency Contacts \n💠 Inform Nearest Police Station \n💠 Audio Recording',
              onTap: () {
                // Handle tracking the product
              },
              buttonText: 'Activate',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    String imagePath,
    String productName,
    String description, {
    VoidCallback? onTap,
    required String buttonText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 5.0,
                        bottom: -10.0,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Transform.scale(
                            scale: 1.2,
                            child: Image.asset('assets/bottom_yellow.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        left: 10.0,
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(imagePath),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Activated $productName'),
                  duration: Duration(seconds: 2),
                ),
              );
              // Call the provided onTap callback
              onTap?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
