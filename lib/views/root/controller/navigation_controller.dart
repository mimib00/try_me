import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;

  List<Widget> screens = [
    Container(color: Colors.red),
    Container(color: Colors.amber),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

  Widget get screen => screens[index.value];

  void goto(int value) {
    index.value = value;
    update();
  }
}
