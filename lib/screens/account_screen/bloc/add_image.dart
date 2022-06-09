import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_group_on/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

Future addImageToFireStorage(File image) async {
  String downloadUrl = "";

  var ref = FirebaseStorage.instance.ref();
  var uuid = Uuid();
  var addImg = await ref.child("image/" + uuid.v4()).putFile(image);
  if (addImg != null) {
    downloadUrl = await addImg.ref.getDownloadURL();
    return downloadUrl;
  }
}

Future<void> addImageToUser(String uri) async {
  var collection = FirebaseFirestore.instance.collection('users');
  collection
      .doc(AppUser.userUid) // <-- Doc ID where data should be updated.
      .update({'userImage': uri}) // <-- Updated data
      .then((_) => print('Updated'))
      .catchError((error) => print('Update failed: $error'));
  AppUser.userImage = uri;
}
