import 'package:get/get.dart';
import 'package:try_me/views/root/controller/navigation_controller.dart';
import 'package:try_me/views/splash/controller/splash_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
