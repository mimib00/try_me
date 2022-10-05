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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                FutureBuilder<List<Post>>(
                  future: controller.getFriendsLatest(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data!.isEmpty) return Container();

                    final posts = snapshot.data!;
                    return SizedBox(
                      width: 100.w,
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return PostCard(post: post);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
