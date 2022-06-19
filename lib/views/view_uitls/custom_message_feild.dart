import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customMessageFeild({
  required BuildContext context,
  bool showBottomMessageErea = false,
}) {
  return Visibility(
    visible: showBottomMessageErea,
    child: Container(
      decoration: BoxDecoration(
        // color: Colors.grey,
        border: BorderDirectional(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 58, 113, 122),
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Write a message',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20.h,
                bottom: 0,
              ),
              child: Image.asset(
                'assets/images/person.png',
                height: 50.w,
                width: 50.w,
              ),
            ),
          ]),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(12.h),
            child: Text('Send',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                )),
          )
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.2,
    ),
  );
}
