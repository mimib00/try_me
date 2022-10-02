import 'package:flutter/material.dart';

class PostInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final Function(String? value)? validator;
  final int lines;
  final TextInputType? keyboardType;
  const PostInput({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.validator,
    this.lines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ),
        validator: (value) => validator?.call(value),
        maxLines: lines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: lines > 1 ? 8 : 0),
          fillColor: Colors.grey[200],
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
