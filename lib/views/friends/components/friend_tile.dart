import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/post_card.dart';

class FriendTile extends StatelessWidget {
  final Users user;
  const FriendTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          SizedBox(
            width: 100.w,
            height: 300,
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return PostCard(user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}
