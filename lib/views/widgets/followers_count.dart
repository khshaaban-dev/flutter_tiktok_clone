import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowersCount extends StatelessWidget {
  final String count;
  final String text;
  final VoidCallback onPressed;
  const FollowersCount({
    Key? key,
    required this.count,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
