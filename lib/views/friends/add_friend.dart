import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/models/user.dart';
import 'package:try_me/meta/widgets/blurry_background.dart';
import 'package:try_me/meta/widgets/loading.dart';
import 'package:try_me/meta/widgets/search_input.dart';
import 'package:try_me/views/friends/components/users_tile.dart';
import 'package:try_me/views/friends/controller/friends_controller.dart';

class AddFriendScreen extends GetView<FriendsController> {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
              onTap: () {
                controller.onClose();
                Get.back();
              },
              child: const BluryBackground()),
        ),
        Positioned.fill(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: controller.form,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchInput(
                              hint: "Suche",
                              onChange: (text) {
                                controller.search.value = text;
                                controller.update();
                              },
                            ),
                            FutureBuilder<List<SearchUser>>(
                              future: controller.searchUsers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: Loading());
                                }
                                if (snapshot.data == null) return Container();

                                final result = snapshot.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    final user = result[index];
                                    return UsersTile(result: user);
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
