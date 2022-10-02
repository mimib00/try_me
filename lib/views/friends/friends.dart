import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';
import 'package:try_me/views/friends/add_friend.dart';
import 'package:try_me/views/friends/controller/friends_controller.dart';

class FriendsScreen extends GetView<FriendsController> {
  const FriendsScreen({super.key});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deine",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.dialog(const AddFriendScreen());
                      },
                      icon: const Icon(
                        TryMeIcons.addFriends,
                        color: ksecondaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Freunde",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
