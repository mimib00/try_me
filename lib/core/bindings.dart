import 'package:get/get.dart';
import 'package:try_me/views/root/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
  }
}
