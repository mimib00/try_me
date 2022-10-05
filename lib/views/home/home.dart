import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/models/post.dart';
import 'package:try_me/meta/widgets/post_card.dart';
import 'package:try_me/views/home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          height: 40,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 40, right: 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Builder(
                        builder: (context) {
                          final name = controller.user.name.split(" ").first;
                          return Text(
                            "Hi $name,",
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hier sind die neuesten Outfits \ndeiner Freunde",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                        ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 100.w,
                    height: 300,
                    child: FutureBuilder<List<Post>>(
                      future: controller.getFriendsLatest(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) return Container();

                        final posts = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return PostCard(post: post);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Hole dir Inspiration in den Kleiderschränken Anderer",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                        ),
                  ),
                  const SizedBox(height: 20),
                  FirestoreQueryBuilder<Future<Post>>(
                    query: controller.publicPosts,
                    builder: (context, snap, _) {
                      if (snap.isFetching) {
                        return const CircularProgressIndicator();
                      }
                      if (snap.hasError) {
                        return Text('error ${snap.error}');
                      }

                      if (snap.docs.isEmpty) return Container();

                      return FutureBuilder<Post>(
                        future: snap.docs.first.data(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) return Container();
                          final post = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snap.docs.length,
                            itemBuilder: (context, index) {
                              return PostCard(post: post);
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
