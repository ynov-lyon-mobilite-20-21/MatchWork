import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:provider/provider.dart';

class Tchat extends StatefulWidget {
  static const route = '/tchat';

  @override
  _TchatState createState() => _TchatState();
}

class _TchatState extends State<Tchat> {
  TextEditingController controller = TextEditingController();
  List<Widget> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtils.closeKeyboard(context: context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Conversation"),
        ),
        body: Column(
          children: [
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
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Taper quelque chose...",
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none),
                      controller: controller,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_camera, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.blueAccent),
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
                BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
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
