import 'package:get/get.dart';
import 'package:try_me/views/friends/controller/friends_controller.dart';
import 'package:try_me/views/root/controller/navigation_controller.dart';
import 'package:try_me/views/splash/controller/splash_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    Get.put(FriendsController());
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
