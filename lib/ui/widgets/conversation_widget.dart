import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/utils/date_utils.dart' as dateUtils;
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class ConversationWidget extends StatefulWidget {
  final Conversation conversation;

  final Function(DismissDirection direction) onDelete;

  const ConversationWidget(
      {Key key, @required this.conversation, @required this.onDelete})
      : super(key: key);

  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
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
                            backgroundColor: theme.indicatorColor,
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
                      borderThickness: 5.0,
                      backgroundColor: theme.indicatorColor,
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
                              style: theme.textTheme.headline4
                                  .copyWith(fontWeight: FontWeight.normal),
                              textScaleFactor: 1.3),
                          Text(
                            widget.conversation.lastMessageContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        dateUtils.DateUtils.isToday(dateLastMessage)
                            ? dateUtils.DateUtils.getHourFormat(dateLastMessage)
                            : dateUtils.DateUtils.getDateFormat(
                                dateLastMessage),
                        style: theme.textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
