import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/widgets/error_card.dart';
import 'package:try_me/meta/widgets/loading.dart';

class AuthController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final loginForm = GlobalKey<FormState>();
  final registerForm = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();
  final confirmPassword = TextEditingController();

  String gender = "Weiblich";

  Rx<File?> photo = Rx(null);

  Rx<Users?> users = Rx(null);

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    photo.value = File(image.path);
    update();
  }

  void unSelectImage() {
    photo.value = null;
    update();
  }

  void login() async {}

  void register() async {
    if (photo.value == null) {
      // Get.snackbar("Error", "Please select a profile picture");
      customSnackBar(message: "Please select a profile picture");
      return;
    }
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      // collect info

      Map<String, dynamic> data = {
        "email": email.text.trim(),
        "name": name.text.trim(),
        "username": username.text.trim(),
        "gender": gender,
        "photo": null,
      };

      // create user
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());

      final user = userCredential.user!;

      // upload user info
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(data);

      // upload user photo
      final storageRef = FirebaseStorage.instance.ref();

      final snapshot = await storageRef.child('profile_pictures/${user.uid}').putFile(
            photo.value!,
            SettableMetadata(
              contentType: "image/jpeg",
            ),
          );

      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) {
        throw "There was an error durring upload";
      }

      // update user photo
      if (snapshot.state == TaskState.success) {
        var imageUrl = await snapshot.ref.getDownloadURL();

        await updateUserInfo({"photo": imageUrl}, user.uid);
      }
      await getUserInfo(user.uid);
      reset();
      Get.back();
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserInfo(String uid) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .withConverter(
            fromFirestore: (snapshot, options) => Users.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (value, options) => {},
          )
          .get();
      users.value = userData.data();
      update();
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }

  Future<void> updateUserInfo(Map<String, dynamic> data, String uid) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(data);
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }

  void reset() {
    email.clear();
    password.clear();
    name.clear();
    username.clear();
    confirmPassword.clear();
  }
}
