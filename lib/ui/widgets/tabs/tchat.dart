import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/views/conversation_view.dart';

import '../profile_picture_widget.dart';
import '../search_bar_widget.dart';

class Tchat extends StatefulWidget {
  static const route = '/tchat';

  @override
  _TchatState createState() => _TchatState();
}

class _TchatState extends State<Tchat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBarWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (_, index) => index < 3
                ? ConversationWidget(
                    caller: new User(firstName: "Prénom", lastName: "NOM"),
                    hasNewMessages: true,
                  )
                : ConversationWidget(
                    caller: new User(firstName: "Prénom", lastName: "NOM")),
          ),
        )
      ],
    );
  }
}

class ConversationWidget extends StatefulWidget {
  final bool hasNewMessages;
  final User caller;

  ConversationWidget(
      {Key key, @required this.caller, this.hasNewMessages = false})
      : super(key: key);

  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  bool hasNewMessages;

  @override
  void initState() {
    super.initState();
    hasNewMessages = widget.hasNewMessages;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasNewMessages) hasNewMessages = false;
        Navigator.of(context)
            .pushNamed(ConversationView.route, arguments: widget.caller);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: hasNewMessages ? Colors.grey : null,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  hasNewMessages
                      ? CircleAvatar(
                          radius: 5.0,
                          backgroundColor: PRIMARY_COLOR,
                        )
                      : Container(
                          width: 10.0,
                        ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ProfilePictureWidget(
                    radius: 35.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.caller.displayName(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: PRIMARY_COLOR),
                          textScaleFactor: 1.3,
                        ),
                        Text(
                          "Dernier message posté par Nom Prenom, test texte très long",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "16/12/2020",
                    textScaleFactor: 0.8,
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey[400],
              height: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
