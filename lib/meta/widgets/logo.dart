import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/logo.svg"),
        const SizedBox(height: 30),
        SvgPicture.asset("assets/images/TRYME.svg"),
      ],
    );
  }
}
