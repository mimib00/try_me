import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:try_me/core/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {}
    });
    super.onInit();
  }
}
