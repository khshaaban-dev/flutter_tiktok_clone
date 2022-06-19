import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTiktokIcon extends StatelessWidget {
  final int currentIndex;
  const CustomTiktokIcon({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 45.w,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(
            left: 10.w,
          ),
          width: 38.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              255,
              250,
              45,
              108,
            ),
            borderRadius: BorderRadius.circular(7.w),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: 10.w,
          ),
          decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                32,
                211,
                234,
              ),
              borderRadius: BorderRadius.circular(7.w)),
        ),
        Center(
          child: Container(
            width: 38.w,
            height: double.infinity,
            decoration: BoxDecoration(
                color: currentIndex > 0 ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(7.w)),
            child: Icon(
              Icons.add,
              color: currentIndex > 0 ? Colors.white : Colors.black,
              size: 33.sp,
            ),
          ),
        ),
      ]),
    );
  }
}
