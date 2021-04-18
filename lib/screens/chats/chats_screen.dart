import 'package:chat/components/coustom_bottom_nav_bar.dart';
import 'package:chat/components/filled_outline_button.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/helperfunctions.dart';
import 'package:chat/screens/chats/chat.dart';
import 'package:chat/screens/chats/search.dart';
import 'package:chat/screens/dialScreen/dial_screen.dart';
import 'package:chat/screens/groupCall/group_call_screen.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';


import '../../constants.dart';
import '../../enums.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Freedom"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.Profile),
      body: StreamBuilder(
        stream: chatRooms,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                      color: kPrimaryColor,
                      child: Row(
                        children: [
                          FillOutlineButton(
                              press: () {}, text: "Recent Message"),
                          SizedBox(width: kDefaultPadding),
                          FillOutlineButton(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GroupCallScreen();
                                  },
                                ),
                              );
                            },
                            text: "Group Call",
                            isFilled: false,
                          ),
                          SizedBox(width: kDefaultPadding),
                          FillOutlineButton(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DialScreen();
                                  },
                                ),
                              );
                            },
                            text: "Call",
                            isFilled: false,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ChatRoomsTile(
                              userName: snapshot.data.docs[index]
                                  .data()['chatRoomId']
                                  .toString()
                                  .replaceAll("_", "")
                                  .replaceAll(Constants.myName, ""),
                              chatRoomId: snapshot.data.docs[index]
                                  .data()["chatRoomId"],
                            );
                          }),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  get press => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        chatRoomId: chatRoomId,
                      )));
        },
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage("assets/images/user_2.png"),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      title: json["notification"]["title"],
      body: json["notification"]["body"],
    );
  }
}
