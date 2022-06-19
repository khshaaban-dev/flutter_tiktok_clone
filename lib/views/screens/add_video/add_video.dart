import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../dialogs/add_video_dailog.dart';

class AddVideoView extends StatelessWidget {
  const AddVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          showOptionsDailog(context);

          
        },
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          alignment: Alignment.center,
          height: 50.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: Text(
            'Add Video',
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ),
      ),
    );
  }
}
