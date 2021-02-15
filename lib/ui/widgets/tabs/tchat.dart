import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/utils/date_utils.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/tchat_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

import '../profile_picture_widget.dart';

class Tchat extends StatefulWidget {
  @override
  _TchatState createState() => _TchatState();
}

class _TchatState extends State<Tchat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<TchatModel>(
        model: TchatModel(authenticationService: Provider.of(context)),
        onModelReady: (model) => model.listenConversationsStream(),
        builder: (context, model, widget) => Column(
              children: [
                model.busy
                    ? CircularProgressIndicator()
                    : SearchBarWidget(
                        primaryColor: theme.focusColor,
                        secondColor: theme.textTheme.caption.color,
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
                                  "Aucun utilisateur trouvé avec cette adresse mail",
                                  style: theme.textTheme.caption),
                            ));
                          }
                        }),
                      ),
                Expanded(
                  child: StreamBuilder<List<Conversation>>(
                    stream: model.outConversations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Conversation> conversations = [...snapshot.data];
                        conversations.sort((Conversation a, Conversation b) => b
                            .lastMessageCreatedAt
                            .compareTo(a.lastMessageCreatedAt));
                        return ListView(
                          children: [
                            ...conversations
                                .where((element) =>
                                    element.isRead == false &&
                                    model.isConversationToDisplay(element))
                                .map((Conversation conversation) =>
                                    ConversationWidget(
                                      conversation: conversation,
                                      theme: theme,
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversationId:
                                                    conversation.id);
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(message,
                                              style: theme.textTheme.caption),
                                        ));
                                      },
                                    )),
                            ...conversations
                                .where((element) =>
                                    element.isRead == true &&
                                    model.isConversationToDisplay(element))
                                .map((Conversation conversation) =>
                                    ConversationWidget(
                                      conversation: conversation,
                                      theme: theme,
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversationId:
                                                    conversation.id);
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(message,
                                              style: theme.textTheme.caption),
                                        ));
                                      },
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

  final Function(DismissDirection direction) onDelete;
  final theme;

  const ConversationWidget(
      {Key key,
      @required this.conversation,
      @required this.onDelete,
      this.theme})
      : super(key: key);

  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime dateLastMessage =
        widget.conversation.lastMessageCreatedAt.toDate();
    return Dismissible(
      key: Key(widget.conversation.id),
      background: Container(color: Colors.red),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmation"),
              content: const Text(
                  "Voulez-vous vraiment supprimer cette conversation?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Supprimer")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Annuler"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: widget.onDelete,
      child: InkWell(
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
                            backgroundColor: AppColors.AccentColor,
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
                              style: widget.theme.textTheme.bodyText1,
                              textScaleFactor: 1.3),
                          Text(
                            widget.conversation.lastMessageContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: widget.theme.textTheme.bodyText1
                                .copyWith(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateUtils.isToday(dateLastMessage)
                          ? DateUtils.getHourFormat(dateLastMessage)
                          : DateUtils.getDateFormat(dateLastMessage),
                      style: widget.theme.textTheme.caption,
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
      ),
    );
  }
}
