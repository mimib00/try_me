import 'dart:ui';

import 'package:flutter/material.dart';

class BluryBackground extends StatelessWidget {
  const BluryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
      ),
    );
  }
}
