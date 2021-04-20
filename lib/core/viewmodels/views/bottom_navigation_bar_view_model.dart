import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';
import 'package:match_work/core/repositories/match_request_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/ui/widgets/tabs/news.dart';
import 'package:match_work/ui/widgets/tabs/profile.dart';
import 'package:match_work/ui/widgets/tabs/swipe.dart';
import 'package:match_work/ui/widgets/tabs/tchat.dart';
import 'package:rxdart/rxdart.dart';

import '../base_model.dart';

class BottomNavigationBarViewModel extends BaseModel {
  final AuthenticationService _authenticationService;

  BottomNavigationBarViewModel(
      {@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  int _currentTab = 1;

  List<Widget> _screens = [Profile(), Swipe(), News(), Tchat()];
  set currentTab(int tab) {
    this._currentTab = tab;
    notifyListeners();
  }

  get currentTab => this._currentTab;
  get currentScreen => this._screens[this._currentTab];

  final MatchRequestRepository _matchRequestRepository =
      MatchRequestRepository();
  final ConversationRepository _conversationRepository =
      ConversationRepository();

  BehaviorSubject<int> _nbMatchRequestsSubject =
      BehaviorSubject<int>.seeded(null);
  Function(int) get _inNbMatchRequests => _nbMatchRequestsSubject.sink.add;
  Stream<int> get outNbMatchRequests => _nbMatchRequestsSubject.stream;

  BehaviorSubject<int> _nbUnreadConversationsSubject =
      BehaviorSubject<int>.seeded(null);
  Function(int) get _inNbUnreadConversations =>
      _nbUnreadConversationsSubject.sink.add;
  Stream<int> get outNbUnreadConversations =>
      _nbUnreadConversationsSubject.stream;

  StreamSubscription listenNbUnreadConversationsStream() {
    return _conversationRepository
        .getNumberUnreadConversations(user: _authenticationService.currentUser)
        .listen((int nbUnreadConversations) {
      if (!_nbUnreadConversationsSubject.isClosed) {
        _inNbUnreadConversations(nbUnreadConversations ?? 0);
      }
    });
  }

  StreamSubscription listenNbMatchRequestsStream() {
    return _matchRequestRepository
        .getNumberMatchRequests(user: _authenticationService.currentUser)
        .listen((int nbMatchRequests) {
      if (!_nbMatchRequestsSubject.isClosed) {
        _inNbMatchRequests(nbMatchRequests ?? 0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nbMatchRequestsSubject.close();
    _nbUnreadConversationsSubject.close();
  }
}
