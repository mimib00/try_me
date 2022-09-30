import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/core/routes/routes.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/custom_button.dart';
import 'package:try_me/meta/widgets/custom_input.dart';
import 'package:try_me/views/auth/components/gender_selector.dart';
import 'package:try_me/views/auth/components/profile_pic_selector.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

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
              child: Form(
                key: controller.registerForm,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SvgPicture.asset(
                        "assets/images/logo.svg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const ProfilePictureSelector(),
                    SizedBox(height: 2.h),
                    CustomInput(
                      controller: controller.name,
                      hint: "Vor- & Nachname",
                    ),
                    CustomInput(
                      controller: controller.username,
                      hint: "Nutzername",
                    ),
                    CustomInput(
                      controller: controller.email,
                      hint: "Emailadresse",
                    ),
                    CustomInput(
                      controller: controller.password,
                      hint: "Passwort",
                    ),
                    CustomInput(
                      controller: controller.confirmPassword,
                      hint: "Passwort wiederholen",
                    ),
                    const SizedBox(height: 20),
                    GenderSelector(
                      onSelect: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          onTap: () {},
                          size: const Size(100, 60),
                          child: const Text('Registrieren'),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Du hast bereits einen Account? ',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offAllNamed(Routes.login),
                          child: Text(
                            'Melde dich an',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kprimaryColor,
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
        ],
      ),
    );
  }
}
