import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/core/bindings.dart';
import 'package:try_me/views/auth/login.dart';
import 'package:try_me/views/auth/register.dart';
import 'package:try_me/views/root/root.dart';
import 'package:try_me/views/splash/splash.dart';

class Routes {
  static const root = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';

  static List<GetPage<dynamic>> allRoutes = [
    GetPage<Widget>(name: root, page: () => const RootScreen(), binding: NavigationBinding()),
    GetPage<Widget>(name: splash, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage<Widget>(name: login, page: () => const LoginScreen()),
    GetPage<Widget>(name: register, page: () => const RegisterScreen()),
  ];
}
