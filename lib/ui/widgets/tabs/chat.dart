import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/utils/date_utils.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/tchat_model.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

import '../profile_picture_widget.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChatModel>(
        model: ChatModel(authenticationService: Provider.of(context)),
        onModelReady: (model) => model.listenConversationsStream(),
        builder: (context, model, widget) => Column(
              children: [
                model.busy
                    ? CircularProgressIndicator()
                    : SearchBarWidget(
                        primaryColor: Theme.of(context).focusColor,
                        secondColor: Theme.of(context).indicatorColor,
                        controller: model.searchController,
                        onChanged: (value) => model.onChangeSearch(),
                        search: () => model.search().then((User user) {
                          if (user != null) {
                            Navigator.of(context).pushNamed(
                                RoutePath.Conversation,
                                arguments: user);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Aucun utilisateur trouvé avec cette adresse mail"),
                            ));
                          }
                        }),
                      ),
                Expanded(
                  child: StreamBuilder<List<Conversation>>(
                    stream: model.outConversations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          children: [
                            ...snapshot.data
                                .where((element) =>
                                    element.isRead == false &&
                                    model.isConversationToDisplay(element))
                                .map((Conversation conversation) =>
                                    ConversationWidget(
                                      conversation: conversation,
                                    )),
                            ...snapshot.data
                                .where((element) =>
                                    element.isRead == true &&
                                    model.isConversationToDisplay(element))
                                .map((Conversation conversation) =>
                                    ConversationWidget(
                                      conversation: conversation,
                                    )),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
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
    DateTime dateLastMessage =
        widget.conversation.lastMessageCreatedAt.toDate();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RoutePath.Conversation,
            arguments: widget.conversation.caller);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  !widget.conversation.isRead &&
                          widget.conversation.senderUid ==
                              widget.conversation.caller.uid
                      ? CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Theme.of(context).indicatorColor,
                        )
                      : Container(
                          width: 10.0,
                        ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ProfilePictureWidget(
                    radius: 35.0,
                    path: widget.conversation.caller.pictureUrl,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.conversation.caller.displayName(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                            textScaleFactor: 1.3),
                        Text(
                          widget.conversation.lastMessageContent,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateUtils.isToday(dateLastMessage)
                        ? DateUtils.getHourFormat(dateLastMessage)
                        : DateUtils.getDateFormat(dateLastMessage),
                    style: Theme.of(context).textTheme.caption,
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
