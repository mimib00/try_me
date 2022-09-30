import 'package:flutter/material.dart';
import 'package:try_me/meta/utils/constants.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool obscure;
  final Function(String? value)? validator;
  const CustomInput({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ),
        obscureText: obscure,
        validator: (value) => validator?.call(value),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: ksecondaryColor.withOpacity(.4),
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          fillColor: Colors.white70,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
