import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';

class UsersTile extends StatelessWidget {
  final SearchUser result;
  const UsersTile({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: CachedNetworkImage(
          imageUrl: result.user.photo,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
      title: Text(
        result.user.name,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text("${result.friends} gemeinsame Freunde"),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          TryMeIcons.addFriends,
          color: kprimaryColor,
        ),
      ),
    );
  }
}
