import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/core/bindings.dart';
import 'package:try_me/views/root/root.dart';

class Routes {
  static const root = '/';

  static List<GetPage<dynamic>> allRoutes = [
    GetPage<Widget>(name: root, page: () => const RootScreen(), binding: NavigationBinding()),
  ];
}
