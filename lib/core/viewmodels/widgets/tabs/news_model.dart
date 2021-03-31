import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_work/core/models/news.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/news_repository.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class NewsModel extends BaseModel {
  final AuthenticationService _authenticationService;

  NewsModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  final NewsRepository _newsRepository = NewsRepository();
  final UserRepository _userRepository = UserRepository();

  BehaviorSubject<List<News>> _newsSubject = BehaviorSubject<List<News>>();
  Function(List<News>) get _inNews => _newsSubject.sink.add;
  Stream<List<News>> get outNews => _newsSubject.stream;

  StreamSubscription listenNewsStream() {
    return _newsRepository.getNewsStream().listen((List<News> news) {
      if (news != null && !_newsSubject.isClosed) {
        _inNews(news);
      }
    });
  }

  Future<User> getUserByNews(News news) async =>
      await _userRepository.getUserByUid(news.userUid);

  Future<bool> likeNews(News news) async {
    busy = true;
    bool success = await _newsRepository.likeNews(
        news: news, user: _authenticationService.currentUser);
    busy = false;
    return success;
  }

  Future<bool> removeLikeNews(News news) async {
    busy = true;
    bool success = await _newsRepository.removeLikeNews(
        news: news, user: _authenticationService.currentUser);
    busy = false;
    return success;
  }

  Future removeNews({@required News news}) async {
    await _newsRepository.removeNews(news: news);
  }

  @override
  void dispose() {
    super.dispose();
    _newsSubject.close();
  }
}
