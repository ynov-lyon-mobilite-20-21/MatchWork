import 'package:flutter/material.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/conversation_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/loaderWidget.dart';
import 'package:match_work/ui/widgets/match_animation_widget.dart';
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
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<ConversationViewModel>(
      child: MatchAnimationWidget(),
      model: ConversationViewModel(
          authenticationService: Provider.of(context), caller: widget.caller),
      onModelReady: (model) {
        model.listenMessageStream();
        model.listenConversationStream();
      },
      builder: (context, model, widget) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: theme.backgroundColor,
              appBar: AppBar(
                backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
                iconTheme:
                    IconThemeData(color: theme.textTheme.headline4.color),
                title: Row(
                  children: [
                    ProfilePictureWidget(
                      path: model.caller.pictureUrl,
                      radius: 15.0,
                      backgroundColor: Colors.grey,
                      borderThickness: 1.5,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      model.caller.displayName(),
                      style: theme.textTheme.headline4,
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: StreamBuilder(
                      stream: model.outMessages,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
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
                                  opacity: index <
                                          messages.length - snapshot.data.length
                                      ? .5
                                      : 1,
                                  child: chatMessage(message,
                                      message.id == model.lastMessageRead?.id),
                                );
                              });
                        }
                        return Center(
                          child: LoaderWidget(
                            opacity: 0.1,
                          ),
                        );
                      },
                    ),
                  )),
                  chatBar(model.controller, () => model.sendMessage())
                ],
              ),
            ),
            model.playingFirstReadingAnimation
                ? widget
                : Visibility(visible: false, child: Container())
          ],
        );
      },
    );
  }

  Widget chatBar(TextEditingController controller, Function onTap) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: theme,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message...",
                ),
                controller: controller,
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () => onTap(),
            child: Icon(
              Icons.send,
              color: theme.textTheme.caption.color,
              size: 30.0,
            ),
          )
        ],
      ),
    );
  }

  Widget chatMessage(ChatMessage message, bool isLastMessageRead) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
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
                        ? theme.primaryColorDark
                        : theme.bottomNavigationBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  message.content,
                  style: TextStyle(
                      color: isMe
                          ? Colors.white
                          : theme.textTheme.headline4.color),
                ),
              ),
              isLastMessageRead
                  ? Icon(
                      Icons.check,
                      color: theme.indicatorColor,
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
