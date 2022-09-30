import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final loginForm = GlobalKey<FormState>();
  final registerForm = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();
  final confirmPassword = TextEditingController();

  Rx<File?> photo = Rx(null);

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

  void register() async {}

  void logout() async {}

  void reset() {
    email.clear();
    password.clear();
    name.clear();
    username.clear();
    confirmPassword.clear();
  }
}
