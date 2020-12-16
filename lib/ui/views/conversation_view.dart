import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class ConversationView extends StatefulWidget {
  static const route = '/conversation';

  final User caller;

  ConversationView({Key key, @required this.caller}) : super(key: key);

  @override
  _ConversationViewState createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  TextEditingController controller = TextEditingController();
  List<Widget> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtils.closeKeyboard(context: context),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: PRIMARY_COLOR,
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfilePictureWidget(
                                radius: 25.0,
                                backgroundColor: Colors.white,
                              ),
                              Text(
                                widget.caller.firstName,
                                textScaleFactor: 1.2,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: messagesList,
                ),
              ),
            )),
            chatBar()
          ],
        ),
      ),
    );
  }

  Widget chatBar() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.face,
                        color: PRIMARY_COLOR,
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Taper quelque chose...",
                          hintStyle: TextStyle(color: PRIMARY_COLOR),
                          border: InputBorder.none),
                      controller: controller,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_camera, color: PRIMARY_COLOR),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file, color: PRIMARY_COLOR),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration:
                BoxDecoration(color: PRIMARY_COLOR, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: () {
                ChatMessage message = ChatMessage(
                    content: controller.text,
                    createdAt: Timestamp.now(),
                    ownerId: Provider.of<User>(context).uid);
                setState(() {
                  messagesList.add(chatMessage(message));
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget chatMessage(ChatMessage message) {
    bool isMe = Provider.of<User>(context).uid == message.ownerId;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                minWidth: 20.0,
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: isMe ? Colors.blueGrey : Colors.blue,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              message.content,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
