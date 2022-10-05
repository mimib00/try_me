import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/models/post.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class HomeController extends GetxController {
  final AuthController authController = Get.find();

  Users get user => authController.users.value!;

  get friendsQuery => FirebaseFirestore.instance.collection("users").doc(user.uid).collection("friends");

  Query<Future<Post>> get publicPosts => FirebaseFirestore.instance
      .collection("posts")
      .where("private", isEqualTo: false)
      .orderBy("created_at", descending: true)
      .withConverter(
        fromFirestore: (snapshot, options) async {
          final userSnap = await FirebaseFirestore.instance.collection("users").doc(snapshot.data()!["owner"]).get();
          final user = Users.fromJson(userSnap.data()!, userSnap.id);
          return Post.fromJson(
            snapshot.data()!,
            snapshot.id,
            user,
          );
        },
        toFirestore: (value, options) => {},
      );

  Future<List<Post>> getFriendsLatest() async {
    final friends = user.friends;
    List<Post> posts = [];

    try {
      for (var friend in friends) {
        final snap = await FirebaseFirestore.instance
            .collection("posts")
            .where("owner", isEqualTo: friend)
            .orderBy("created_at", descending: true)
            .limit(1)
            .withConverter(
              fromFirestore: (snapshot, options) async {
                final userSnap =
                    await FirebaseFirestore.instance.collection("users").doc(snapshot.data()!["owner"]).get();
                final user = Users.fromJson(userSnap.data()!, userSnap.id);
                return Post.fromJson(
                  snapshot.data()!,
                  snapshot.id,
                  user,
                );
              },
              toFirestore: (value, options) => {},
            )
            .get();
        if (snap.docs.isNotEmpty) {
          posts.add(await snap.docs.first.data());
        }
      }
    } on FirebaseException catch (e) {
      log(e.code);
    }

    return posts;
  }
}
