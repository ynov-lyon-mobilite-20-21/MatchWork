import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static String newsReference = 'news';
  static String usersReference = 'users';

  static Future<String> _uploadFile(
      {@required firebase_storage.Reference reference,
      @required File file}) async {
    if (file == null) {
      return null;
    }

    firebase_storage.TaskSnapshot result = await reference.putFile(file);
    String url = await result.ref.getDownloadURL();

    return url;
  }

  static Future<bool> deleteFileFromFirebaseByUrl(
      {@required String urlFile}) async {
    String fileName = urlFile.replaceAll("/o/", "*");
    fileName = fileName.replaceAll("?", "*");
    fileName = fileName.replaceAll("%2F", "/");
    fileName = fileName.split("*")[1];
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref();
    return await storageReference
        .child(fileName)
        .delete()
        .then((_) => true)
        .catchError((error) => false);
  }

  static Future<String> uploadImageNews(File file) async {
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(newsReference)
        .child('/${Timestamp.now().millisecondsSinceEpoch}');
    return _uploadFile(file: file, reference: ref);
  }

  static Future<String> uploadImageUser(File file) async {
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(usersReference)
        .child('/${Timestamp.now().millisecondsSinceEpoch}');
    return _uploadFile(file: file, reference: ref);
  }

  static Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString());
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(imageUrl);
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  static Future<File> assetToFile(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}