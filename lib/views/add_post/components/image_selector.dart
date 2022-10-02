import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/views/add_post/controller/add_post_controller.dart';

class ImageSelector extends GetView<AddPostController> {
  const ImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.photo.value == null) {
          return GestureDetector(
            onTap: () {
              controller.selectImage();
            },
            child: Container(
              alignment: Alignment.center,
              height: 200,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 35,
              ),
            ),
          );
        } else {
          return Stack(
            children: [
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    controller.photo.value!,
                    height: 200,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
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
              ),
            ],
          );
        }
      },
    );
  }
}
