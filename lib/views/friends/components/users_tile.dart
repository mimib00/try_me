import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';
import 'package:try_me/views/friends/controller/friends_controller.dart';

class UsersTile extends StatefulWidget {
  final SearchUser result;
  const UsersTile({
    super.key,
    required this.result,
  });

  @override
  State<UsersTile> createState() => _UsersTileState();
}

class _UsersTileState extends State<UsersTile> {
  final FriendsController controller = Get.find();

  late bool show;

  bool loading = false;

  @override
  void initState() {
    show = widget.result.isFriend;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: CachedNetworkImage(
          imageUrl: widget.result.user.photo,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
      title: Text(
        widget.result.user.name,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text("${widget.result.friends} gemeinsame Freunde"),
      trailing: Visibility(
        visible: show,
        child: IconButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            final sent = await controller.sendInvite(widget.result.user.uid);

            setState(() {
              show = sent;
            });
          },
          icon: loading
              ? const CircularProgressIndicator()
              : const Icon(
                  TryMeIcons.addFriends,
                  color: kprimaryColor,
                ),
        ),
      ),
    );
  }
}
