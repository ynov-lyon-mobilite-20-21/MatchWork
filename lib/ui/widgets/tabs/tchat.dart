import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/match_request.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/tchat_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/conversation_widget.dart';
import 'package:match_work/ui/widgets/loaderWidget.dart';
import 'package:match_work/ui/widgets/match_request_widget.dart';
import 'package:match_work/ui/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

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
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<TchatModel>(
        model: TchatModel(authenticationService: Provider.of(context)),
        onModelReady: (model) {
          model.listenConversationsStream();
          model.listenMatchRequestsStream();
        },
        builder: (context, model, widget) => Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20),
                  child: SearchBarWidget(
                      primaryColor: theme.focusColor,
                      secondColor: theme.textTheme.caption.color,
                      controller: model.searchController,
                      onChanged: (value) => model.onChangeSearch()),
                ),
                StreamBuilder(
                    stream: model.outMatchRequests,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<MatchRequest> matchRequests = [...snapshot.data];
                        if (matchRequests.length > 0) {
                          return Container(
                            color:
                                theme.bottomNavigationBarTheme.backgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpandablePanel(
                                theme: ExpandableThemeData(
                                    expandIcon: Icons.keyboard_arrow_down,
                                    collapseIcon: Icons.keyboard_arrow_up,
                                    iconColor: theme.textTheme.headline4.color),
                                header: Text("Nouveaux contacts",
                                    style: theme.textTheme.headline4
                                        .copyWith(fontSize: 18.0)),
                                collapsed: Text(
                                  "${matchRequests.length} demande${matchRequests.length > 1 ? 's' : ''} de connexion en attente",
                                  style: theme.textTheme.subtitle2
                                      .copyWith(fontSize: 14.0),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                expanded: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.4),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...matchRequests.map(
                                            (MatchRequest matchRequest) =>
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: MatchRequestWidget(
                                                        user: matchRequest.user,
                                                        accept: () async => await model
                                                            .acceptMatchRequest(
                                                                matchRequest:
                                                                    matchRequest),
                                                        reject: () async => await model
                                                            .rejectMatchRequest(
                                                                matchRequest:
                                                                    matchRequest)),
                                                  ),
                                                ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return Container();
                    }),
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
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversation: conversation);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(message),
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
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversation: conversation);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(message),
                                        ));
                                      },
                                    )),
                          ],
                        );
                      }
                      return LoaderWidget(opacity: 0.0);
                    },
                  ),
                ),
              ],
            ));
  }
}
