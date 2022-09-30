import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/utils/constants.dart';

class Loading extends StatelessWidget {
  final String message;
  const Loading({
    super.key,
    this.message = "Loading",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 3.w),
                const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: kprimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
