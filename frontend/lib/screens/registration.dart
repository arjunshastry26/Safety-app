import 'package:flutter/material.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late TextEditingController _phoneController;
  late TextEditingController _otpController;
  String _otpSentTo = "";
  bool _isOtpScreen = false;
  bool _isOtpResendAvailable = false;
  Timer? _timer;
  int _resendOtpCounter = 30; // Timer for resend OTP

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _phoneController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _sendOtp() {
    setState(() {
      _otpSentTo = _phoneController.text;
      _isOtpScreen = true;
      _animationController.forward();
    });

    // Simulate sending OTP
    Future.delayed(Duration(seconds: 2), () {
      print("OTP sent to: $_otpSentTo");
      _startResendOtpTimer();
    });
  }

  void _verifyOtp() {
    // Simulate OTP verification
    if (_otpController.text == "1234") {
      print("OTP Verified!");
    } else {
      print("Incorrect OTP!");
    }
  }

  void _resendOtp() {
    setState(() {
      _resendOtpCounter = 30;
      _isOtpResendAvailable = false;
    });
    _sendOtp();
  }

  void _startResendOtpTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendOtpCounter == 0) {
        setState(() {
          _isOtpResendAvailable = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _resendOtpCounter--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              Text(
                _isOtpScreen ? "OTP Verification" : "Phone Registration",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              if (!_isOtpScreen) ...[
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Enter Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _sendOtp,
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38.0),
                    ),
                    backgroundColor: Color(0xff132137),
                  ),
                  child: Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ] else ...[
                Text(
                  "OTP sent to $_otpSentTo",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38.0),
                    ),
                    backgroundColor: Color(0xff132137),
                  ),
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                if (_isOtpResendAvailable)
                  InkWell(
                    onTap: _resendOtp,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Text(
                    "Resend available in $_resendOtpCounter seconds",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
