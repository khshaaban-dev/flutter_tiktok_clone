import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../constants/constants.dart';
import '../view_uitls/share_bottom_sheet.dart';
import '../view_uitls/show_bottom_sheet.dart';
import 'see_more_text.dart';

class ChannelVideoPreviewItem extends StatelessWidget {
  const ChannelVideoPreviewItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 40,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => const VideoItemPage(),
    );
  }
}

class VideoItemPage extends StatefulWidget {
  const VideoItemPage({Key? key}) : super(key: key);

  @override
  State<VideoItemPage> createState() => _VideoItemPageState();
}

class _VideoItemPageState extends State<VideoItemPage> {
  late VideoPlayerController controller;
  bool isPaused = false;
  @override
  void initState() {
    controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/tiktik-clone-bd54c.appspot.com/o/videos%2FeFUkXJ4VvFZgFXPN3oDTMkcMxsO2?alt=media&token=e48c8406-0699-41ff-a641-c955be740c00')
      ..initialize().then((value) {
        //controller.play();
        controller.setVolume(1);
        controller.setLooping(false);
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPaused = !isPaused;
        });
        isPaused ? controller.play() : controller.pause();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // todo video

          SizedBox.expand(
            child: VideoPlayer(
              controller,
            ),
          ),

          // details sectios

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: EdgeInsets.only(
                  bottom: Platform.isAndroid
                      ? kBottomNavigationBarHeight + 20
                      : 90 + 20,
                ),
                child: const VideoDiscription()),
          ),
          Align(
            alignment: Alignment.bottomRight,
            // alignment: Alignment.bottomRight,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.only(
                  bottom: Platform.isAndroid
                      ? kBottomNavigationBarHeight + 20
                      : 90 + 20,
                ),
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                // color: Colors.amber,
                child: const VideoDetails()),
          ),
          if (!isPaused)
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.grey.shade200.withOpacity(0.25),
                size: 80.sp,
              ),
            ),
        ],
      ),
    );
  }
}

class VideoDetails extends StatelessWidget {
  const VideoDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const FollowBlusButton(
          profileUrl: 'assets/images/person.png',
        ),
        DitailsCount(
          isFav: true,
          icon: Icons.favorite,
          count: 664,
          onPressed: () async {
            //todo
          },
        ),
        DitailsCount(
          icon: Icons.maps_ugc,
          count: 552,
          onPressed: () {
            showCommentsBottomSheet(context);
          },
        ),
        DitailsCount(
          icon: Icons.subdirectory_arrow_right,
          count: 55,
          onPressed: () {
            showSearchBottomSheet(context, isMainScreen: true);
          },
        ),
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VideoDiscription extends StatelessWidget {
  const VideoDiscription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                '@userName',
                textAlign: TextAlign.left,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 4.sp,
            ),
            const ExpandableText(
              data:
                  'captioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaption\ncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptioncaptionca\nptioncaptioncaptioncaptioncaptioncaption',
            ),
            SizedBox(
              height: 4.sp,
            ),
            GestureDetector(
                onTap: () {},
                child: Text(
                  'See translation',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
            SizedBox(
              height: 4.sp,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children: [
                  const Icon(
                    Icons.music_note_rounded,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      'original sound--songName',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class DitailsCount extends StatelessWidget {
  final int count;
  final IconData? icon;

  final VoidCallback onPressed;
  final bool isFav;
  const DitailsCount({
    Key? key,
    required this.count,
    this.icon,
    required this.onPressed,
    this.isFav = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 33.sp,
            color: isFav ? buttonColor : Colors.white,
          ),
        ),
        Text(
          '$count',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FollowBlusButton extends StatelessWidget {
  final String profileUrl;
  const FollowBlusButton({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(profileUrl),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: Icon(
              Icons.add_circle,
              color: buttonColor,
            ),
          ),
        ],
      ),
    );
  }
}

typedef ChangeTabs = void Function({required bool isForYou});

class HomeTabs extends StatelessWidget {
  final bool isForYou;
  final ChangeTabs changTabs;
  const HomeTabs({
    Key? key,
    required this.isForYou,
    required this.changTabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            changTabs(isForYou: false);
          },
          child: AnimatedDefaultTextStyle(
            curve: Curves.easeOutBack,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !isForYou
                  ? Colors.white
                  : Colors.grey.shade200.withOpacity(0.4),
              fontSize: isForYou ? 14.sp : 16.sp,
            ),
            duration: const Duration(milliseconds: 250),
            child: const Text(
              'Following',
              textAlign: TextAlign.end,
            ),
          ),
        ),
        isForYou
            ? Container(
                width: 8.w,
                height: 8.w,
                margin: EdgeInsets.only(
                  bottom: 15.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4.w),
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: 15.sp,
          height: 10.sp,
          child: RotatedBox(
            quarterTurns: 45,
            child: Divider(
              color: Colors.grey.shade200.withOpacity(0.4),
              thickness: 1,
              height: 2,
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              changTabs(isForYou: true);
            },
            child: AnimatedDefaultTextStyle(
              curve: Curves.easeOutBack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isForYou
                    ? Colors.white
                    : Colors.grey.shade200.withOpacity(0.4),
                fontSize: isForYou ? 16.sp : 14.sp,
              ),
              duration: const Duration(milliseconds: 250),
              child: const Text(
                'For You',
              ),
            )),
      ],
    );
  }
}
