import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/views/auth/controller/auth_controller.dart';

class ProfilePictureSelector extends GetView<AuthController> {
  const ProfilePictureSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectImage();
      },
      child: Obx(
        () {
          return controller.photo.value == null
              ? const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  foregroundColor: ksecondaryColor,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 30,
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: Image.file(
                          controller.photo.value!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.unSelectImage();
                        },
                        child: const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.close_rounded),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
