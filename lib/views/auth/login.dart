import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/core/routes/routes.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/custom_button.dart';
import 'package:try_me/meta/widgets/custom_input.dart';
import 'package:try_me/meta/widgets/logo.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/splash.png",
              height: 100.h,
              width: 150.w,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff894731).withOpacity(.3),
                    const Color(0xff464646).withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: controller.loginForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: const Logo(
                          logoSize: Size(60, 60),
                          nameSize: Size(35, 35),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomInput(
                        controller: controller.email,
                        hint: "Nutzername oder Emailadresse",
                      ),
                      CustomInput(
                        controller: controller.password,
                        hint: "Passwort",
                        obscure: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () {},
                        size: const Size(100, 60),
                        child: const Text('Login'),
                      ),
                      SizedBox(height: 11.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Du hast noch keinen Account? ',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          GestureDetector(
                            onTap: () => Get.offAllNamed(Routes.register),
                            child: Text(
                              'Registriere dich',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kprimaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Passwort vergessen',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
