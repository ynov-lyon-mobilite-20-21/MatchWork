import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/news.dart' as news_model;
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/date_utils.dart' as date_utils;
import 'package:match_work/core/viewmodels/widgets/tabs/news_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/news_form_view.dart';
import 'package:match_work/ui/widgets/loader_widget.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<NewsModel>(
        model: NewsModel(authenticationService: Provider.of(context)),
        onModelReady: (model) => model.listenNewsStream(),
        builder: (context, model, widget) => SafeArea(
              child: Column(
                children: [
                  Container(
                    color: theme.cardColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfilePictureWidget(
                            path: Provider.of<AuthenticationService>(context)
                                .currentUser
                                .pictureUrl,
                            radius: 20.0,
                            backgroundColor: theme.indicatorColor,
                            borderThickness: 2.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () => showModal(context: context),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color:
                                              AppColors.CircleAvatarBorderColor,
                                          width: 2.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Ecrire une publication",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder<List<news_model.News>>(
                    stream: model.outNews,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<news_model.News> news = [...snapshot.data];
                        return ListView.builder(
                            itemCount: news.length,
                            itemBuilder: (context, index) {
                              return newsWidget(
                                  context: context,
                                  news: news[index],
                                  userFuture: model.getUserByNews(news[index]),
                                  likeNews: model.likeNews,
                                  removeLikeNews: model.removeLikeNews,
                                  removeNews: model.removeNews);
                            });
                      }
                      return LoaderWidget();
                    },
                  ))
                ],
              ),
            ));
  }
}

Future showModal({@required BuildContext context, news_model.News news}) =>
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) => NewsFormView(
              news: news,
            ));

Widget newsWidget(
    {@required BuildContext context,
    @required news_model.News news,
    @required Future<User> userFuture,
    @required Function likeNews,
    @required Function removeLikeNews,
    @required Function removeNews}) {
  ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

  return Card(
    color: theme.cardColor,
    child: FutureBuilder<User>(
      future: userFuture,
      initialData: User(firstName: "", lastName: ""),
      builder: (context, snapshot) {
        User user = snapshot.data;
        bool isMe = user.uid ==
            Provider.of<AuthenticationService>(context).currentUser.uid;
        DateTime creationDate = news.createdAt.toDate();
        bool isLiked = news.likedBy.contains(
            Provider.of<AuthenticationService>(context).currentUser.uid);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      ProfilePictureWidget(
                        backgroundColor: theme.indicatorColor,
                        borderThickness: 2.0,
                        radius: 20.0,
                        path: user.pictureUrl,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName(),
                            style: theme.textTheme.bodyText1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            date_utils.DateUtils.isToday(creationDate)
                                ? date_utils.DateUtils.getHourFormat(
                                    creationDate)
                                : date_utils.DateUtils.getDateFormat(
                                    creationDate),
                            style: theme.textTheme.subtitle2,
                          )
                        ],
                      )
                    ],
                  ),
                  isMe
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () =>
                                  showModal(context: context, news: news),
                              child: Icon(
                                Icons.edit,
                                color: theme.textTheme.subtitle2.color,
                                size: 30.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Suppression d'un post"),
                                        content: Text(
                                            "Voulez-vous vraiment supprimer ce post?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text("Annuler")),
                                          TextButton(
                                              onPressed: () async {
                                                removeNews(news: news);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Supprimer",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      )),
                              child: Icon(
                                Icons.delete_forever,
                                color: theme.textTheme.subtitle2.color,
                                size: 30.0,
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
              news.pictureUrl != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.20),
                        child: Image.network(
                          news.pictureUrl,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  : Container(),
              news.content != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        news.content,
                        style:
                            theme.textTheme.subtitle1.copyWith(fontSize: 14.0),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () =>
                          isLiked ? removeLikeNews(news) : likeNews(news),
                      child: Column(
                        children: [
                          Icon(
                            isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            color: theme.textTheme.subtitle1.color,
                            size: 25.0,
                          ),
                          Text(
                            news.likedBy.length.toString(),
                            style: theme.textTheme.subtitle1,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
