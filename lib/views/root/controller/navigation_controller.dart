import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/views/friends/friends.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;

  List<Widget> screens = [
    Container(color: Colors.red),
    const FriendsScreen(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

  Widget get screen => screens[index.value];

  void goto(int value) {
    index.value = value;
    update();
  }
}
