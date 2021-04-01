import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/user.dart';
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
        onModelReady: (model) => model.listenConversationsStream(),
        builder: (context, model, widget) => Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20),
                  child: SearchBarWidget(
                    primaryColor: theme.focusColor,
                    secondColor: theme.textTheme.caption.color,
                    controller: model.searchController,
                    onChanged: (value) => model.onChangeSearch(),
                    search: () => model.search().then((User user) {
                      if (user != null) {
                        Navigator.of(context)
                            .pushNamed(RoutePath.Conversation, arguments: user);
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Aucun utilisateur trouvé avec cette adresse mail",
                              style: theme.textTheme.caption),
                        ));
                      }
                    }),
                  ),
                ),
                Container(
                  color: theme.bottomNavigationBarTheme.backgroundColor,
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
                        "3 demandes de connexion en attente",
                        style:
                            theme.textTheme.subtitle2.copyWith(fontSize: 14.0),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.4),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MatchRequestWidget(
                                  user: User(
                                      firstName: "prenom", lastName: "nom"),
                                  accept: () => null,
                                  reject: () => null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MatchRequestWidget(
                                  user: User(
                                      firstName: "prenom", lastName: "nom"),
                                  accept: () => null,
                                  reject: () => null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MatchRequestWidget(
                                  user: User(
                                      firstName: "prenom", lastName: "nom"),
                                  accept: () => null,
                                  reject: () => null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversation: conversation);
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
                                      onDelete: (direction) async {
                                        String message =
                                            await model.removeConversation(
                                                conversation: conversation);
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
                      return LoaderWidget(opacity: 0.0);
                    },
                  ),
                ),
              ],
            ));
  }
}
