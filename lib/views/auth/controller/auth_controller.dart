// ignore_for_file: no_leading_underscores_for_local_identifiers

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

  /// takes a [username] and get the [email] of the user.
  Future<String?> getEmail(String user) async {
    String? email;
    try {
      final snap = await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: user).get();
      if (snap.docs.first.exists) {
        email = snap.docs.first.data()["email"];
      }
    } on FirebaseException catch (e) {
      log(e.code);
    }
    return email;
  }

  void login() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);

      // get email
      final input = email.text.trim();
      String? _email;
      if (!input.isEmail) {
        final value = await getEmail(input);
        if (value == null) {
          customSnackBar(message: "Username doesn't exist");
          return;
        }
        _email = value;
      } else {
        _email = input;
      }

      // try to login
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: password.text.trim());

      final user = userCredential.user!;

      // get User data
      await getUserInfo(user.uid);
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      log(e.code);
    }
    reset();
  }

  void register() async {
    if (photo.value == null) {
      customSnackBar(message: "Please select a profile picture");
      return;
    }
    if (await getEmail(username.text.trim()) != null) {
      customSnackBar(message: "Username exist");
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
        "private": false,
        "created_at": FieldValue.serverTimestamp(),
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
      Get.back();
    } catch (e) {
      Get.back();
      log(e.toString());
    }
    reset();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserInfo(String uid) async {
    try {
      final friends = await FirebaseFirestore.instance.collection("users").doc(uid).collection("friends").get();
      final friendList = friends.docs.map((e) => e.data()["friend_id"]).toList().cast<String>();
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .withConverter<Users>(
            fromFirestore: (snapshot, options) => Users.fromJson(snapshot.data()!, snapshot.id, friendList: friendList),
            toFirestore: (value, options) => {},
          )
          .get();
      users = Rx(userData.data());
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
