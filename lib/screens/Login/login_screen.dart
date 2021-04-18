import 'package:chat/components/already_have_an_account_acheck.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/components/text_field_container.dart';
import 'package:chat/helper/helperfunctions.dart';
import 'package:chat/screens/Signup/components/background.dart';
import 'package:chat/screens/Signup/signup_screen.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  SignInScreen(this.toggleView);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0].data()["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0].data()["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Background(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SIGNIN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        height: size.height * 0.35,
                      ),
                      SizedBox(height: size.height * 0.03),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldContainer(
                              child: TextFormField(
                                controller: emailEditingController,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct email";
                                },
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: kPrimaryColor,
                                  ),
                                  hintText: "Your Email",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                controller: passwordEditingController,
                                validator: (val) {
                                  return val.length < 6
                                      ? "Enter Password 6+ characters"
                                      : null;
                                },
                                obscureText: true,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                        text: "SIGNIN",
                        press: () {
                          signIn();
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: AlreadyHaveAnAccountCheck(
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen(widget.toggleView);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
