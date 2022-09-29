import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/core/bindings.dart';
import 'package:try_me/views/root/root.dart';
import 'package:try_me/views/splash/splash.dart';

class Routes {
  static const root = '/';
  static const splash = '/splash';

  static List<GetPage<dynamic>> allRoutes = [
    GetPage<Widget>(name: root, page: () => const RootScreen(), binding: NavigationBinding()),
    GetPage<Widget>(name: splash, page: () => const SplashScreen()),
  ];
}
