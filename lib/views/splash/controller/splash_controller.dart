import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:try_me/core/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.root);
      }
    });
    super.onInit();
  }
}
