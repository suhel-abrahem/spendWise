import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showMessage({
  required String message,
  required BuildContext context,
  bool haveButton = false,
  String? buttonTitle,
  VoidCallback? onPressed,
  int duration = 3000,
}) {
  final snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 3.h, left: 3.w, right: 3.w),
    backgroundColor: Colors.black,
    padding: EdgeInsets.all(1.w),
    content: SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Wrap(
                  children: [
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (haveButton)
            SizedBox(
              width: 50.w,
              height: 30.h,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonTitle ?? ''),
              ),
            ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    duration: Duration(milliseconds: duration),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
