import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildButton({
  required BuildContext context,
  required VoidCallback onPressed,
  Color? color,
  Color? bBorderColor,
  required String text,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: bBorderColor ?? Colors.transparent),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(
            color: color != null ? Colors.white : Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
        ),
      ),
    ),
  );
}
