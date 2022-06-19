import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDivider() {
  return SizedBox(
    width: 20.sp,
    height: 20.sp,
    child: RotatedBox(
      quarterTurns: 45,
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
        height: 20,
      ),
    ),
  );
}
