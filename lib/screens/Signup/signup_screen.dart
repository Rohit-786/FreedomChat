import 'package:chat/components/already_have_an_account_acheck.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/components/text_field_container.dart';
import 'package:chat/helper/helperfunctions.dart';
import 'package:chat/screens/Login/login_screen.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'components/background.dart';
import 'components/or_divider.dart';
import 'components/social_icon.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  SignUpScreen(this.toggleView);


  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
            if(result != null){

              Map<String,String> userDataMap = {
                "userName" : emailEditingController.text,
                "userEmail" : emailEditingController.text
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(emailEditingController.text);
              HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
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
                      "SIGNUP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
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
                      text: "SIGNUP",
                      press: () {
                        singUp();
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignInScreen(widget.toggleView);
                            },
                          ),
                        );
                      },
                    ),
                    OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {
                            AuthMethods().signInWithGoogle(context);
                            
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
