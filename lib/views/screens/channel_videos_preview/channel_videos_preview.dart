import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/constants.dart';
import '../../view_uitls/share_bottom_sheet.dart';
import '../../view_uitls/show_bottom_sheet.dart';
import '../../widgets/see_more_text.dart';

class ChannelVideosPreview extends StatefulWidget {
  static const String route = '/channelVideosPreview';
  const ChannelVideosPreview({Key? key}) : super(key: key);

  @override
  State<ChannelVideosPreview> createState() => _ChannelVideosPreviewState();
}

class _ChannelVideosPreviewState extends State<ChannelVideosPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 3, 3, 56),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: const [
          ChannelVideoPreviewItem(),
          Align(
            //   alignment: Alignment(0.0, 1.0),
            alignment: Alignment.bottomCenter,
            child: CommentSection(),
          ),
        ],
      ),
    );
  }
}

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
                    bottom: MediaQuery.of(context).size.height * 0.1),
                child: const VideoDiscription()),
          ),
          Align(
            alignment: Alignment.bottomRight,
            // alignment: Alignment.bottomRight,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1),
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

class CommentSection extends StatelessWidget {
  const CommentSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12).copyWith(
        bottom: 0,
      ),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.1,
      child: GestureDetector(
        onTap: () {
          showCommentsBottomSheet(context);
        },
        child: TextField(
          decoration: InputDecoration(
            enabled: false,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.alternate_email,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            hintText: 'Add comment...',
          ),
        ),
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
