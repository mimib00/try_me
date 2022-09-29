import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_me/core/routes/routes.dart';
import 'package:try_me/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Try Me',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.root,
      getPages: Routes.allRoutes,
    );
  }
}
