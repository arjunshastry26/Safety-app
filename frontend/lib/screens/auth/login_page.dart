import 'package:flutter/material.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/screens/auth/forgot_page.dart';
import 'package:frontend/screens/auth/signup_page.dart';
import 'package:frontend/screens/main/main_page.dart';

class CustomNumberPad extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomNumberPad({Key? key, required this.onKeyPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('1', context),
            _buildButton('2', context),
            _buildButton('3', context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('4', context),
            _buildButton('5', context),
            _buildButton('6', context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('7', context),
            _buildButton('8', context),
            _buildButton('9', context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('DEL', context),
            _buildButton('0', context),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            onKeyPressed(text);
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _pinController;

  @override
  void initState() {
    _pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'DEL' && _pinController.text.isNotEmpty) {
        _pinController.text =
            _pinController.text.substring(0, _pinController.text.length - 1);
      } else if (key != 'DEL' && _pinController.text.length < 4) {
        _pinController.text += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Voyage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: darkGrey,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Enter your 4-digit PIN',
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkGrey,
                ),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    _pinController.text.length,
                    (index) => _buildDot(),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              CustomNumberPad(
                onKeyPressed: _onKeyPressed,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_pinController.text == '2807') {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => MainPage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incorrect PIN. Please try again.'),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('Submit', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    child: Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ForgotPinPage()));
                    },
                    child: Text('Forgot PIN?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
