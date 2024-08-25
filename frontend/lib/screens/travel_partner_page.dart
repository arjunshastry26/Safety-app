import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Add this package to your pubspec.yaml
import 'package:frontend/app_properties.dart'; // Import your app properties if needed

class SafeTravelPartnerPage extends StatefulWidget {
  @override
  _SafeTravelPartnerPageState createState() => _SafeTravelPartnerPageState();
}

class _SafeTravelPartnerPageState extends State<SafeTravelPartnerPage> {
  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Travel Partner'),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for places...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Map
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    37.7749, -122.4194), // Default position (San Francisco)
                zoom: 12,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to home or another page
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search or navigate
              },
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                // Handle chat or navigate
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile or another page
              },
            ),
          ],
        ),
      ),
    );
  }
}
