import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:try_me/meta/models/outfit.dart';
import 'package:try_me/meta/widgets/loading.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class AddPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final AuthController controller = Get.find();

  final form = GlobalKey<FormState>();

  final name = TextEditingController();
  final size = TextEditingController();
  final brand = TextEditingController();
  final color = TextEditingController();
  final notes = TextEditingController();

  Rx<File?> photo = Rx(null);

  List<OutfitPices> pices = [];

  RxBool isPrivate = false.obs;

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

  void addPost() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      final user = controller.users.value!;
      // collect data
      Map<String, dynamic> data = {
        "name": name.text.trim(),
        "size": size.text.trim(),
        "brand": brand.text.trim(),
        "notes": notes.text.trim(),
        "photo": null,
        "pices": pices.map((e) => e.name).toList(),
        "private": isPrivate.value,
        "owner": user.uid,
        "created_at": FieldValue.serverTimestamp(),
      };

      // create post

      final snap = await FirebaseFirestore.instance.collection("posts").add(data);

      // upload image
      final storageRef = FirebaseStorage.instance.ref();

      final snapshot = await storageRef.child('posts/${snap.id}').putFile(
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

        await updatePost({"photo": imageUrl}, snap.id);
      }

      Get.back();
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      log(e.code);
    }
  }

  Future<void> updatePost(Map<String, dynamic> data, String uid) async {
    try {
      await FirebaseFirestore.instance.collection("posts").doc(uid).update(data);
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }

  @override
  void onClose() {
    name.clear();
    size.clear();
    brand.clear();
    color.clear();
    notes.clear();
    photo.value = null;
    isPrivate.value = false;
    pices.clear();
    super.onClose();
  }
}
