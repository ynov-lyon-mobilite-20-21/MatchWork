import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/news.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/utils/storage_utils.dart';

class NewsRepository {
  static String contentReference = 'content';
  static String pictureUrlReference = 'pictureUrl';
  static String userUidReference = 'userUid';
  static String createdAtReference = 'createdAt';
  static String editedAtReference = 'editedAt';
  static String likedByReference = 'likedBy';

  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

  Future<String> postNews(
      {@required User user, File image, String content}) async {
    News news = News(userUid: user.uid, createdAt: Timestamp.now());
    if (image != null) {
      try {
        news.pictureUrl = await StorageUtils.uploadImageNews(image);
      } catch (e) {
        return "Erreur lors de l'upload du fichier";
      }
    }
    if (content != null && content.trim() != '') {
      news.content = content;
    }
    if (news.pictureUrl == null && news.content == null) {
      return "Veuillez entrer un contenu ou sélectionner une image";
    }
    await _newsCollection.add(news.toJson());
    return null;
  }

  Future<String> editNews(
      {@required News news, File image, String content}) async {
    if (news.pictureUrl != null) {
      bool successDeletion = await StorageUtils.deleteFileFromFirebaseByUrl(
          urlFile: news.pictureUrl);
      if (!successDeletion) {
        return "Erreur lors de la suppression de l'ancienne image";
      }
      news.pictureUrl = null;
    }
    if (image != null) {
      try {
        news.pictureUrl = await StorageUtils.uploadImageNews(image);
      } catch (e) {
        return "Erreur lors de l'upload du fichier";
      }
    }

    news.content = null;
    if (content != null && content.trim() != '') {
      news.content = content;
    }
    if (news.pictureUrl == null && news.content == null) {
      return "Veuillez entrer un contenu ou sélectionner une image";
    }
    news.editedAt = Timestamp.now();
    await _newsCollection.doc(news.id).update({
      editedAtReference: news.editedAt,
      pictureUrlReference: news.pictureUrl,
      contentReference: news.content
    });
    return null;
  }

  Future<String> removeNews({@required News news}) async {
    if (news.pictureUrl != null) {
      bool successDeletion = await StorageUtils.deleteFileFromFirebaseByUrl(
          urlFile: news.pictureUrl);
      if (!successDeletion) {
        return "Erreur lors de la suppression de l'image";
      }
    }

    await _newsCollection.doc(news.id).delete().onError(
        (error, stackTrace) => "Erreur lors de la suppression du post");
    return null;
  }

  Future removeNewsByUser({@required User user}) async {
    QuerySnapshot snapshot = await _newsCollection
        .where(userUidReference, isEqualTo: user.uid)
        .get();
    snapshot.docs.forEach((DocumentSnapshot documentSnapshot) async {
      News news = News.fromSnapshot(documentSnapshot);
      await this.removeNews(news: news);
    });
  }

  Stream<List<News>> getNewsStream() => _newsCollection
          .orderBy(createdAtReference, descending: true)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.length == 0) return [];
        return querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                News.fromSnapshot(documentSnapshot))
            .toList();
      });

  Future<bool> likeNews({@required News news, @required User user}) async {
    if (!news.likedBy.contains(user.uid)) {
      news.likedBy.add(user.uid);
    }
    await _newsCollection
        .doc(news.id)
        .update({likedByReference: news.likedBy}).catchError((error) => false);
    return true;
  }

  Future<bool> removeLikeNews(
      {@required News news, @required User user}) async {
    if (news.likedBy.contains(user.uid)) {
      news.likedBy.removeWhere((element) => element == user.uid);
    }
    await _newsCollection
        .doc(news.id)
        .update({likedByReference: news.likedBy}).catchError((error) => false);
    return true;
  }
}
