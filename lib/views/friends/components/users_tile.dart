import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';
import 'package:try_me/views/friends/controller/friends_controller.dart';
import 'package:try_me/views/profile/profile.dart';

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
      onTap: () {
        Get.bottomSheet(ProfileScreen(user: widget.result.user));
      },
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
              ? const CircularProgressIndicator(color: kprimaryColor)
              : const Icon(
                  TryMeIcons.addFriends,
                  color: kprimaryColor,
                ),
        ),
      ),
    );
  }
}

class UserRequestTile extends StatefulWidget {
  final SearchUser result;
  const UserRequestTile({
    super.key,
    required this.result,
  });

  @override
  State<UserRequestTile> createState() => _UserRequestTileState();
}

class _UserRequestTileState extends State<UserRequestTile> {
  final FriendsController controller = Get.find();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.bottomSheet(ProfileScreen(user: widget.result.user));
      },
      contentPadding: EdgeInsets.zero,
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
      horizontalTitleGap: 5,
      trailing: loading
          ? const CircularProgressIndicator(color: kprimaryColor)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      final sent = await controller.changeInviteStatus(widget.result.uid, true);
                      if (sent) {
                        Get.back();
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Icon(Icons.check_rounded),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: kprimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      final sent = await controller.changeInviteStatus(widget.result.uid, false);
                      if (sent) {
                        Get.back();
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: kprimaryColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
