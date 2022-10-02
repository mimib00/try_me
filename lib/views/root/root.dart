import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';
import 'package:try_me/views/add_post/add_post.dart';
import 'package:try_me/views/add_post/controller/add_post_controller.dart';
import 'package:try_me/views/root/controller/navigation_controller.dart';

class RootScreen extends GetView<NavigationController> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          extendBody: true,
          body: controller.screen,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: (index) {
              controller.goto(index);
            },
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: ksecondaryColor,
            selectedItemColor: kprimaryColor,
            items: [
              const BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Freunde",
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person),
                    Icon(Icons.person),
                  ],
                ),
              ),
              const BottomNavigationBarItem(
                label: "Kalender",
                icon: Icon(TryMeIcons.calander),
              ),
              BottomNavigationBarItem(
                label: "Kleiderschrank",
                icon: SvgPicture.asset(
                  "assets/images/logo.svg",
                  color: controller.index.value == 3 ? kprimaryColor : ksecondaryColor,
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.put(AddPostController());
              Get.dialog(const AddPostScreen());
            },
            child: const Icon(
              Icons.add_rounded,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
