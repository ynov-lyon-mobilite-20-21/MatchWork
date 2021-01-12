import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/tchat_model.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/conversation_view.dart';
import 'package:provider/provider.dart';

import '../profile_picture_widget.dart';

class Tchat extends StatefulWidget {
  static const route = '/tchat';

  @override
  _TchatState createState() => _TchatState();
}

class _TchatState extends State<Tchat> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<TchatModel>(
        model: TchatModel(authenticationService: Provider.of(context)),
        onModelReady: (model) => model.getConversations(),
        builder: (context, model, widget) => StreamBuilder<List<Conversation>>(
              stream: model.getConversations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      ...snapshot.data
                          .where((element) => element.isRead == false)
                          .map(
                              (Conversation conversation) => ConversationWidget(
                                    conversation: conversation,
                                  )),
                      ...snapshot.data
                          .where((element) => element.isRead == true)
                          .map(
                              (Conversation conversation) => ConversationWidget(
                                    conversation: conversation,
                                  )),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ));
  }
}

class ConversationWidget extends StatefulWidget {
  final Conversation conversation;

  ConversationWidget({Key key, @required this.conversation}) : super(key: key);

  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ConversationView.route, arguments: widget.conversation);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: widget.conversation.isRead ? null : Colors.grey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  !widget.conversation.isRead
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
                          widget.conversation.caller.displayName(),
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
