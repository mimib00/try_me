import 'package:flutter/material.dart';
import 'package:try_me/meta/utils/try_me_icons_icons.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(TryMeIcons.calander),
      ),
    );
  }
}
