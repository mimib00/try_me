import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final Size? size;
  const CustomButton({
    super.key,
    required this.child,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(fixedSize: MaterialStatePropertyAll(size)),
        child: child,
      ),
    );
  }
}
