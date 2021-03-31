import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/news_repository.dart';

class News {
  String id;
  String userUid;
  String content;
  String pictureUrl;
  Timestamp createdAt;
  Timestamp editedAt;
  List likedBy = [];

  User user;

  News({this.id, this.userUid, this.content, this.pictureUrl, this.createdAt});

  News.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        userUid = snapshot.data()[NewsRepository.userUidReference],
        content = snapshot.data()[NewsRepository.contentReference],
        pictureUrl = snapshot.data()[NewsRepository.pictureUrlReference],
        createdAt = snapshot.data()[NewsRepository.createdAtReference],
        editedAt = snapshot.data()[NewsRepository.editedAtReference],
        likedBy = snapshot.data()[NewsRepository.likedByReference];

  Map<String, dynamic> toJson() => {
        NewsRepository.contentReference: content,
        NewsRepository.pictureUrlReference: pictureUrl,
        NewsRepository.userUidReference: userUid,
        NewsRepository.createdAtReference: createdAt,
        NewsRepository.editedAtReference: editedAt,
        NewsRepository.likedByReference: likedBy
      };
}
