import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match_work/core/models/news.dart';
import 'package:match_work/core/repositories/news_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/storage_utils.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class NewsFormViewModel extends BaseModel {
  AuthenticationService _authenticationService;
  News news;

  NewsRepository _newsRepository = NewsRepository();
  File image;
  TextEditingController controller = TextEditingController();

  NewsFormViewModel(
      {@required AuthenticationService authenticationService, this.news})
      : _authenticationService = authenticationService;

  Future initialData() async {
    if (news != null) {
      busy = true;
      controller.text = news.content;
      if (news.pictureUrl != null) {
        image = await StorageUtils.urlToFile(news.pictureUrl);
      }
      busy = false;
    }
  }

  Future getImgFromCamera() async {
    busy = true;
    image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    busy = false;
  }

  Future getImgFromGallery() async {
    busy = true;
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    busy = false;
  }

  void removeImage() {
    busy = true;
    image = null;
    busy = false;
  }

  Future<bool> postNews() async {
    busy = true;
    if (controller.text.trim() != '' || image != null) {
      String error = await _newsRepository.postNews(
          user: _authenticationService.currentUser,
          image: image,
          content: controller.text.trim());
      return error == null;
    }
    busy = false;
    return false;
  }

  Future<bool> editNews() async {
    busy = true;
    if (controller.text.trim() != '' || image != null) {
      String error = await _newsRepository.editNews(
          news: news, image: image, content: controller.text.trim());
      return error == null;
    }
    busy = false;
    return false;
  }
}
