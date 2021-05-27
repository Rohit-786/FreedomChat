import 'package:chat/screens/audioCallWithImage/audio_call_with_image_screen.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFF00BF6D);
    return Container(
      padding: EdgeInsets.symmetric(vertical:3),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.messenger),
                      color: MenuState.Chats == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatRoom();
                            },
                          ),
                        );
                      }),
                  new Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  color: MenuState.People == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Call.svg",
                  color: MenuState.Call == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AudioCallWithImage();
                      },
                    ),
                  );
                },
              ),
              IconButton(
                  icon: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage("assets/images/user_2.png"),
                  ),
                  color: MenuState.Profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileScreen();
                        },
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
