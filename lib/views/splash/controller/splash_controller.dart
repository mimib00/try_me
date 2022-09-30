import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:try_me/core/routes/routes.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    final AuthController authController = Get.find();
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        await authController.getUserInfo(user.uid);
        Get.offAllNamed(Routes.root);
      }
    });
    super.onInit();
  }
}
