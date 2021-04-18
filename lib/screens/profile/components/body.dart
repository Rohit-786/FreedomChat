import 'package:chat/helper/authenticate.dart';
import 'package:chat/helper/helperfunctions.dart';
import 'package:chat/helper/shared_pref_helper.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/google_auth.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AuthService authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Account'),
                      ),
                      body: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            ProfileMenu(
                              text: 'Privacy',
                              icon: "assets/icons/Lock.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: 'Security',
                              icon: "assets/icons/Lock.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: 'Change Number',
                              icon: "assets/icons/Phone.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: 'Delete my account',
                              icon: "assets/icons/Lock.svg",
                              press: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {
              AuthMethods().signOut().then((s) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Authenticate(false)));
              });
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "assets/images/1_No Connection.png",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 100,
                            left: 30,
                            child: FlatButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {},
                              child: Text("Retry".toUpperCase()),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "assets/images/2_404 Error.png",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.15,
                            left: MediaQuery.of(context).size.width * 0.3,
                            right: MediaQuery.of(context).size.width * 0.3,
                            child: FlatButton(
                              color: Color(0xFF6B92F2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {},
                              child: Text(
                                "Go Home".toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              AuthService().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Authenticate(false);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
