import 'package:flutter/material.dart';
import 'package:frontend/screens/contacts_page.dart';

class EmergencyCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          height: 80,
                          width: 80,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Emergency Call Settings',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Set up your preferred way to trigger an emergency call quickly and easily.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Trigger Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _showGestureModal(context),
                      child: ListTile(
                        leading: Icon(Icons.gesture, color: Colors.green[800]),
                        title: Text('Set Gesture'),
                        subtitle:
                            Text('Activate an emergency call with a gesture.'),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.green[800]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showVoiceCommandModal(context),
                      child: ListTile(
                        leading: Icon(Icons.mic, color: Colors.green[800]),
                        title: Text('Set Voice Command'),
                        subtitle: Text(
                            'Initiate an emergency call with a voice command.'),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.green[800]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showHardwareButtonModal(context),
                      child: ListTile(
                        leading: Icon(Icons.hardware, color: Colors.green[800]),
                        title: Text('Set Hardware Button Combination'),
                        subtitle: Text(
                            'Start an emergency call using your phone’s hardware buttons.'),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.green[800]),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Emergency Contacts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmergencyContactsScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.contacts, color: Colors.green[800]),
                        title: Text('Manage Emergency Contacts'),
                        subtitle: Text(
                            'Add, edit, or remove your emergency contact numbers.'),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.green[800]),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Handle initiating emergency call
                },
                child: PulseAnimation(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[800],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Gesture Modal with 9 Dots
  void _showGestureModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Set Gesture',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Swipe across the dots to create your gesture pattern.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // 9 Dots Grid
              GestureDetector(
                onPanUpdate: (details) {
                  // Capture the gesture swipes (logic needs to be implemented)
                },
                child: Container(
                  height: 200,
                  width: 200,
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[800],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the gesture settings
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                ),
                child: Center(child: Text('Save Gesture')),
              ),
            ],
          ),
        );
      },
    );
  }

  // Voice Command Modal with Recording Feature
  void _showVoiceCommandModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Set Voice Command',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Press the mic to record your voice command.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // Mic IconButton for Recording
              IconButton(
                icon: Icon(Icons.mic, size: 50, color: Colors.green[800]),
                onPressed: () {
                  // Start recording the voice command
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the voice command settings
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                ),
                child: Center(child: Text('Save Voice Command')),
              ),
            ],
          ),
        );
      },
    );
  }

  // Hardware Button Combination Modal
  void _showHardwareButtonModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Set Hardware Button Combination',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Select a combination of hardware buttons to trigger the emergency call.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // Dropdown for selecting hardware buttons
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose Button Combination',
                  labelStyle: TextStyle(color: Colors.green[800]),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Volume Up + Power',
                    child: Text('Volume Up + Power'),
                  ),
                  DropdownMenuItem(
                    value: 'Volume Down + Power',
                    child: Text('Volume Down + Power'),
                  ),
                  DropdownMenuItem(
                    value: 'Power Button (Triple Press)',
                    child: Text('Power Button (Triple Press)'),
                  ),
                ],
                onChanged: (value) {
                  // Handle selection
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the hardware button settings
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                ),
                child: Center(child: Text('Save Hardware Setting')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PulseAnimation extends StatefulWidget {
  final Widget child;

  PulseAnimation({required this.child});

  @override
  _PulseAnimationState createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
