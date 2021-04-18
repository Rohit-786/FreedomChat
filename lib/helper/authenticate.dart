import 'package:chat/screens/Login/login_screen.dart';
import 'package:chat/screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  bool value;
  Authenticate(this.value);
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  void toggleView() {
    setState(() {
      widget.value = !widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value) {
      return SignInScreen(toggleView);
    } else {
      return SignUpScreen(toggleView);
    }
  }
}
