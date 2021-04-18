import 'package:chat/components/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: camel_case_types
class roundedd extends StatefulWidget {
  @override
  _roundeddState createState() => _roundeddState();
}

// ignore: camel_case_types
class _roundeddState extends State<roundedd> {

   TextEditingController emailEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: emailEditingController,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(Icons.person,
            color: kPrimaryColor,
          ),
          hintText: "Your Email",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
