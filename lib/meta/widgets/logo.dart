import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class Logo extends StatelessWidget {
  final Size? logoSize;
  final Size? nameSize;
  const Logo({
    super.key,
    this.logoSize,
    this.nameSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/logo.svg",
          height: logoSize?.height,
          width: logoSize?.width,
        ),
        SizedBox(height: 3.h),
        SvgPicture.asset(
          "assets/images/TRYME.svg",
          height: nameSize?.height,
          width: nameSize?.width,
        ),
      ],
    );
  }
}
