import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../animations/icon_bounce_animation.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Comment(),
        isOpened
            ? AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 2),
                        physics: const BouncingScrollPhysics(),
                        itemCount: 12,
                        itemBuilder: (context, index) => const Comment()),
                  ),
                ),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: () {
            setState(() {
              isOpened = !isOpened;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              Text(
                isOpened ? ' Hide' : 'Show',
                style: TextStyle(fontSize: 10.sp),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Comment extends StatefulWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 14.w,
            backgroundColor: Colors.grey,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('user Name',
                  style: TextStyle(
                    fontSize: 10.sp,
                  )),
              Text(
                'the comment it self...',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: IconBounceAnimation(),
        ),
      ],
    );
  }
}
