import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/models/post.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/post_card.dart';
import 'package:try_me/views/profile/profile.dart';

class FriendTile extends StatelessWidget {
  final Users user;
  const FriendTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.bottomSheet(ProfileScreen(user: user, isFriend: true));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: CachedNetworkImage(
                        imageUrl: user.photo,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                  color: ksecondaryColor,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100.w,
            height: 300,
            child: FirestoreListView(
              scrollDirection: Axis.horizontal,
              pageSize: 5,
              query: FirebaseFirestore.instance
                  .collection("posts")
                  .where("owner", isEqualTo: user.uid)
                  .orderBy("created_at", descending: true)
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
                  ),
              itemBuilder: (context, doc) {
                return FutureBuilder<Post>(
                  future: doc.data(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    final post = snapshot.data!;
                    return PostCard(post: post);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
