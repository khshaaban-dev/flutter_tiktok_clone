import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/utils/pick_video.dart';
import '../screens/confirm_add_video_screen/confirm_add_video_screen.dart';

internalPickImage({
  required BuildContext context,
  required ImageSource source,
}) async {
  final image = await pickVideo(source: ImageSource.camera);
  if (image != null) {
    Navigator.pop(context);
    Navigator.pushNamed(context, ConfirmAddVideoScreen.route, arguments: {
      'videoFile': File(image),
      'videoPath': image,
    });
    return;
  }
  Navigator.pop(context);
}

showOptionsDailog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  internalPickImage(
                    context: context,
                    source: ImageSource.camera,
                  );
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  internalPickImage(
                    context: context,
                    source: ImageSource.gallery,
                  );
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.close),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ));
}
