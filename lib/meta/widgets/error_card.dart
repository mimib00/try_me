import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar({bool error = true, required String message}) => Get.snackbar(
      error ? "Error!" : "Success!",
      message,
      borderRadius: 0,
      margin: const EdgeInsets.all(10),
      backgroundColor: error ? Colors.red.shade100.withOpacity(0.3) : Colors.green.shade100.withOpacity(0.3),
      leftBarIndicatorColor: error ? Colors.red.shade700 : Colors.green.shade700,
      snackPosition: SnackPosition.TOP,
    );
