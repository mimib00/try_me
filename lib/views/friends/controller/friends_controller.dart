import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class FriendsController extends GetxController {
  final form = GlobalKey<FormState>();

  final AuthController controller = Get.find();

  RxString search = "".obs;

  Future<List<SearchUser>> searchUsers() async {
    final userSnap = await FirebaseFirestore.instance
        .collection("users")
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (value, options) => {},
        )
        .where("username", isEqualTo: search.value)
        .where("username", isNotEqualTo: controller.users.value!.username)
        .get();

    final user = userSnap.docs.first.data();

    final snap = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("friends").get();
    final userData = SearchUser.fromJson(user, snap.docs.length);
    return [userData];
  }

  @override
  void onClose() {
    search = RxString("");
    super.onClose();
  }
}
