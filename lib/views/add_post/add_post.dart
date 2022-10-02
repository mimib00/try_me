import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/blurry_background.dart';
import 'package:try_me/meta/widgets/custom_button.dart';
import 'package:try_me/meta/widgets/error_card.dart';
import 'package:try_me/views/add_post/components/image_selector.dart';
import 'package:try_me/views/add_post/components/pices_selector.dart';
import 'package:try_me/views/add_post/components/post_input.dart';
import 'package:try_me/views/add_post/controller/add_post_controller.dart';

class AddPostScreen extends GetView<AddPostController> {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
              onTap: () {
                controller.onClose();
                Get.back();
              },
              child: const BluryBackground()),
        ),
        Positioned.fill(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: controller.form,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ImageSelector(),
                            SizedBox(height: 3.h),
                            PicesSelector(
                              onSelect: (pice) {
                                controller.pices.add(pice);
                              },
                              onUnSelect: (pice) {
                                controller.pices.remove(pice);
                              },
                            ),
                            const Divider(),
                            PostInput(
                              controller: controller.name,
                              hint: 'Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Pflichtfeld";
                                return null;
                              },
                            ),
                            PostInput(
                              controller: controller.size,
                              hint: 'Größe',
                              keyboardType: TextInputType.number,
                            ),
                            PostInput(
                              controller: controller.brand,
                              hint: 'Marke',
                            ),
                            PostInput(
                              controller: controller.color,
                              hint: 'Farbe',
                            ),
                            PostInput(
                              controller: controller.color,
                              hint: 'Notizen',
                              lines: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Privatgelände:"),
                                CupertinoSwitch(
                                  value: controller.isPrivate.value,
                                  onChanged: (status) {
                                    controller.isPrivate.value = status;
                                    controller.update();
                                  },
                                  activeColor: kprimaryColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    if (controller.photo.value == null) {
                                      customSnackBar(message: "Please select a profile picture");
                                      return;
                                    }
                                    if (controller.pices.isEmpty) {
                                      customSnackBar(message: "Please select at least 1 pice");
                                      return;
                                    }
                                    if (controller.form.currentState!.validate()) {
                                      controller.addPost();
                                    }
                                  },
                                  size: const Size(100, 60),
                                  child: const Text('Hochladen'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
