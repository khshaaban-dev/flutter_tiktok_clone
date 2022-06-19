// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:tik_tik_clone_all_fetures/views/view_uitls/share_bottom_sheet.dart';
// import 'package:video_player/video_player.dart';

// import 'package:tik_tik_clone_all_fetures/data/models/models.dart';

// import '../../constants/constants.dart';
// import '../view_uitls/show_bottom_sheet.dart';
// import 'see_more_text.dart';

// class VideoPlayerItem extends StatefulWidget {
//   final VideoModel videoModel;

//   const VideoPlayerItem({
//     Key? key,
//     required this.videoModel,
//   }) : super(key: key);

//   @override
//   State<VideoPlayerItem> createState() => _VideoPlayerItemState();
// }

// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//   late VideoPlayerController controller;

//   int discriptionMaxLines = 4;
//   bool isMoreThanFourLines = false;
//   bool isSeeMoreClicked = false;

//   @override
//   void initState() {
//     controller = VideoPlayerController.network(widget.videoModel.videoUrl)
//       ..initialize().then((value) {
//         //controller.play();
//         controller.setVolume(1);
//         controller.setLooping(false);
//       });

//     super.initState();
//   }

//   Widget _videoDiscription() {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: Platform.isAndroid ? kBottomNavigationBarHeight + 10 : 90 + 10,
//         left: 20.sp,
//       ),
//       child: Align(
//         alignment: Alignment.bottomLeft,
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: Text(
//                     '@${widget.videoModel.userName}',
//                     textAlign: TextAlign.left,
//                     maxLines: 1,
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4.sp,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: Stack(children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: ExpandableText(
//                         data: widget.videoModel.caption,
//                       ),
//                     ),
//                   ]),
//                 ),
//                 SizedBox(
//                   height: 4.sp,
//                 ),
//                 GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       'See translation',
//                       style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     )),
//                 SizedBox(
//                   height: 4.sp,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.music_note_rounded,
//                         color: Colors.white,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'original sound-${widget.videoModel.songName}',
//                           maxLines: 1,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }

//   double getKeyboardHeight(BuildContext context) {
//     return MediaQuery.of(context).viewInsets.bottom;
//   }

//   Widget _videoDatiels() {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: Platform.isAndroid ? kBottomNavigationBarHeight + 10 : 90 + 10,
//         right: 10.w,
//       ),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.5,
//           width: Platform.isAndroid ? kBottomNavigationBarHeight - 10 : 90,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               FollowBlusButton(profileUrl: widget.videoModel.userProfielUrl),
//               DitailsCount(
//                 isFav: true,
//                 icon: Icons.favorite,
//                 count: widget.videoModel.likesCount,
//                 onPressed: () async {
//                   //   await VideoRepostory().toggleLike();

//                   //   context.read<AuthBloc>().add(SignOutEvent());
//                 },
//               ),
//               DitailsCount(
//                 icon: Icons.maps_ugc,
//                 count: widget.videoModel.conmmentsCount,
//                 onPressed: () {
//                   showCommentsBottomSheet(context);
//                 },
//               ),
//               DitailsCount(
//                 svgIcon: const Svg(
//                   'assets/icons/share.svg',
//                   color: Colors.white,
//                 ),
//                 count: widget.videoModel.shareCount,
//                 onPressed: () {
//                   showSearchBottomSheet(context, isMainScreen: true);
//                 },
//               ),
//               SizedBox(
//                 height: 60.h,
//                 width: double.infinity,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.black,
//                   child: Padding(
//                     padding: EdgeInsets.all(6.h),
//                     child: const CircleAvatar(
//                       backgroundColor: Colors.white,
//                       backgroundImage: NetworkImage(
//                         'https://firebasestorage.googleapis.com/v0/b/tiktik-clone-bd54c.appspot.com/o/thumbnail%2FeFUkXJ4VvFZgFXPN3oDTMkcMxsO2?alt=media&token=aaa18de9-c368-4457-ae52-940e9e7d226e',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool isPused = false;
//   bool hidePlayIcon = false;
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Stack(children: [
//       GestureDetector(
//         onTapDown: (d) {
//           if (isPused) {
//             controller.play();
//             setState(() {
//               isPused = false;
//             });
//             Future.delayed(const Duration(seconds: 2), () {
//               setState(() {
//                 hidePlayIcon = false;
//               });
//             });
//           } else {
//             controller.pause();
//             setState(() {
//               isPused = true;
//               hidePlayIcon = true;
//             });
//           }
//         },
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.black,
//           ),
//           width: size.width,
//           height: size.height,
//           child: VideoPlayer(controller),
//         ),
//       ),
//       _videoDiscription(),
//       _videoDatiels(),
//       hidePlayIcon
//           ? IgnorePointer(
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 400),
//                 child: Center(
//                     child: Icon(
//                   isPused ? Icons.play_arrow_rounded : null,
//                   color: Colors.grey.shade200.withOpacity(0.4),
//                   size: 80.sp,
//                 )),
//               ),
//             )
//           : const SizedBox(),
//     ]);
//   }
// }

// class DitailsCount extends StatelessWidget {
//   final int count;
//   final IconData? icon;
//   final Svg? svgIcon;
//   final VoidCallback onPressed;
//   final bool isFav;
//   const DitailsCount({
//     Key? key,
//     required this.count,
//     this.icon,
//     this.svgIcon,
//     required this.onPressed,
//     this.isFav = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60.h,
//       width: double.infinity,
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: icon != null
//                 ? IconButton(
//                     onPressed: onPressed,
//                     icon: Icon(
//                       icon,
//                       size: 33.sp,
//                       color: isFav ? buttonColor : Colors.white,
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: onPressed,
//                     child: Image(
//                       width: 32,
//                       height: 32,
//                       image: svgIcon!,
//                     ),
//                   ),
//           ),
//           Expanded(
//             child: Text(
//               '$count',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FollowBlusButton extends StatelessWidget {
//   final String profileUrl;
//   const FollowBlusButton({
//     Key? key,
//     required this.profileUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       width: double.infinity,
//       height: 50.h,
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: CircleAvatar(
//               radius: 20.w,
//               backgroundColor: Colors.white,
//               backgroundImage: NetworkImage(profileUrl),
//             ),
//           ),
//           Positioned(
//             bottom: 0.h,
//             right: 10.w,
//             // alignment: Alignment.center,
//             child: Icon(
//               Icons.add_circle,
//               color: buttonColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DiscriptionText extends StatefulWidget {
//   final String discription;
//   const DiscriptionText({
//     Key? key,
//     required this.discription,
//   }) : super(key: key);

//   @override
//   State<DiscriptionText> createState() => _DiscriptionTextState();
// }

// class _DiscriptionTextState extends State<DiscriptionText> {
//   bool isMoreThanFourLines = false;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: ((context, size) {
//         if (size.maxHeight > 4.8) {
//           setState(() {
//             isMoreThanFourLines = true;
//           });
//         } else {
//           isMoreThanFourLines = false;
//         }
//         return Text(
//           widget.discription,
//           maxLines: 4,
//           style: const TextStyle(height: 1.2),
//           overflow: TextOverflow.ellipsis,
//         );
//       }),
//     );
//   }
// }
