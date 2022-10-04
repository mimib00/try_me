import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/core/config.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class FriendsController extends GetxController {
  final dio = Dio();
  final form = GlobalKey<FormState>();

  final AuthController controller = Get.find();

  RxString search = "".obs;

  get friendsQuery =>
      FirebaseFirestore.instance.collection("users").doc(controller.users.value!.uid).collection("friends");

  // Future<List<Users>> getFriends() async {

  //   try {
  //     final snap = ;
  //   } on FirebaseException catch (e) {
  //     log(e.message ?? "");
  //   }
  //   return [];
  // }

  Future<Users> getFriendInfo(String uid) async {
    Users? user;
    try {
      final snap = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      user = Users.fromJson(snap.data()!, snap.id);
    } on FirebaseException catch (e) {
      log(e.code);
    }
    return user!;
  }

  Future<List<SearchUser>> getInvites() async {
    final user = controller.users.value!;
    var data = <Map<String, dynamic>>[];

    try {
      final response = await dio.post(
        getInvite,
        data: {
          'uid': user.uid,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        data = response.data["result"].cast<Map<String, dynamic>>();
      }
    } on DioError catch (e) {
      log(e.message);
    }
    List<SearchUser> users = [];

    for (var doc in data) {
      final friend = Users.fromJson(doc["user"], doc["user"]["uid"]);
      final friends = await getMutalFriend(user.uid, friend.uid);
      users.add(SearchUser.fromJson(doc["id"], friend, friends, false));
    }
    return users;
  }

  Future<int> getMutalFriend(String uid, String friendId) async {
    var friendsCount = 0;
    try {
      final response = await dio.post(
        getMutalFriends,
        data: {
          'uid': uid,
          'friend_id': friendId,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      friendsCount = response.data["result"]["mutal_friends"];
    } on DioError catch (e) {
      log(e.message);
    }
    return friendsCount;
  }

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
    final friendsCount = await getMutalFriend(controller.users.value!.uid, user.uid);

    final isFriend = controller.users.value!.friends.contains(user.uid);
    final userData = SearchUser.fromJson(userSnap.docs.first.id, user, friendsCount, isFriend);
    return [userData];
  }

  Future<bool> sendInvite(String uid) async {
    final user = controller.users.value!;
    bool sent = false;
    try {
      final response = await dio.post(
        addFriend,
        data: {
          'sender': user.uid,
          'friend': uid,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        sent = true;
      }
    } on DioError catch (e) {
      log(e.message);
      sent = false;
    }

    return sent;
  }

  Future<bool> changeInviteStatus(String requestId, bool status) async {
    bool sent = false;
    try {
      final response = await dio.post(
        changeFriendRequestStatus,
        data: {
          'uid': requestId,
          'user': controller.users.value!.uid,
          "status": status,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        sent = true;
      }
    } on DioError catch (e) {
      log(e.message);
      sent = false;
    }
    return sent;
  }

  @override
  void onClose() {
    search = RxString("");
    super.onClose();
  }
}
