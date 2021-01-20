import 'dart:io';

import 'package:flutter/material.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/conversation_view_model.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class ConversationView extends StatefulWidget {
  final User caller;

  ConversationView({Key key, @required this.caller}) : super(key: key);

  @override
  _ConversationViewState createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ConversationViewModel>(
      model: ConversationViewModel(
          authenticationService: Provider.of(context), caller: widget.caller),
      onModelReady: (model) {
        model.listenMessageStream();
        model.listenConversationStream();
      },
      builder: (context, model, widget) => Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).appBarTheme.color,
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
                                path: model.caller.pictureUrl,
                                radius: 25.0,
                                backgroundColor: Colors.white,
                              ),
                              Text(
                                model.caller.firstName,
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
                child: StreamBuilder(
              stream: model.outMessages,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                if (snapshot.hasData) {
                  List<ChatMessage> messages = [
                    ...model.sendingMessages.reversed,
                    ...snapshot.data
                  ];
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (_, int index) {
                        ChatMessage message = messages[index];
                        return Opacity(
                          opacity:
                              index < messages.length - snapshot.data.length
                                  ? .5
                                  : 1,
                          child: chatMessage(
                              message, message.id == model.lastMessageRead?.id),
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            chatBar(model.controller, () => model.sendMessage())
          ],
        ),
      ),
    );
  }

  Widget chatBar(TextEditingController controller, Function onTap) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    hintText: "Message...",
                    hintStyle:
                        TextStyle(color: Theme.of(context).indicatorColor),
                    border: InputBorder.none),
                controller: controller,
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () => onTap(),
            child: Icon(
              Icons.send,
              color: Theme.of(context).indicatorColor,
            ),
          )
        ],
      ),
    );
  }

  Widget chatMessage(ChatMessage message, bool isLastMessageRead) {
    bool isMe = Provider.of<AuthenticationService>(context).currentUser.uid ==
        message.ownerId;
    double widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: isMe
          ? EdgeInsets.only(top: 8.0, right: 10.0, left: (widthScreen * 0.2))
          : EdgeInsets.only(top: 8.0, left: 10.0, right: (widthScreen * 0.2)),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                    minWidth: 20.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: isMe
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10.0),
                    border: isMe ? null : Border.all(color: Colors.white)),
                child: Text(
                  message.content,
                  style: TextStyle(
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).indicatorColor),
                ),
              ),
              isLastMessageRead
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).indicatorColor,
                      size: 15.0,
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
