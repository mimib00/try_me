import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';

class ProfileScreen extends StatelessWidget {
  final Users user;
  final bool isMe;
  final bool isFriend;
  const ProfileScreen({
    super.key,
    required this.user,
    this.isMe = false,
    this.isFriend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  TryMeIcons.chat,
                  color: kprimaryColor,
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: CachedNetworkImage(
                      imageUrl: user.photo,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Icon(
                        user.isPrivate ? Icons.lock : Icons.lock_open,
                        color: kprimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              isFriend
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person_remove,
                        size: 35,
                        color: kprimaryColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        TryMeIcons.addFriends,
                        color: kprimaryColor,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const StatsTile(title: "Outfits", value: 15),
              StatsTile(title: "Friends", value: user.friends.length),
              const StatsTile(title: "Outfits", value: 15),
            ],
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  final String title;
  final int value;
  const StatsTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.titleSmall!,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
