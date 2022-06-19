
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/screens.dart';

class VideoImagePreview extends StatelessWidget {
  final int index;
  const VideoImagePreview({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChannelVideosPreview.route,
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/person.png',
            fit: BoxFit.cover,
          ),
          if (index < 2)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(1)),
                child: Text('Pinned',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.play_arrow_outlined,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                  Text(
                    '13.9K',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
