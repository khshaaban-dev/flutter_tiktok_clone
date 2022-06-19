import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../loading/loading_screen_controller.dart';

class CommentSection {
  // singleton object
  CommentSection._sharedInstance();
  static final CommentSection _shared = CommentSection._sharedInstance();
  factory CommentSection.instance() => _shared;
  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    }
    controller = _showLoadingScreen(context: context, text: text);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  OverlayState? state;

  OverlayEntry? overlayEntry;
  LoadingScreenController _showLoadingScreen({
    required BuildContext context,
    required String text,
  }) {
    var _text = StreamController<String>();
    _text.add(text);
    state = Overlay.of(context);
    var renderbox = context.findRenderObject() as RenderBox;

    var size = renderbox.size;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return BottomOvlay(
          size: size,
        );
      },
    );
    state?.insert(overlayEntry!);
    return LoadingScreenController(
      close: () {
        _text.close();
        overlayEntry!.remove();
        return true;
      },
      update: (text) {
        _text.add(text);
        return true;
      },
    );
  }

  void updateOverlay() {
    overlayEntry!.markNeedsBuild();
  }
}

class BottomOvlay extends StatefulWidget {
  final Size size;
  const BottomOvlay({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<BottomOvlay> createState() => _BottomOvlayState();
}

class _BottomOvlayState extends State<BottomOvlay> {
  bool isExpanded = false;
  late TextEditingController controller;
  bool isEmpty = true;
  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        setState(() {
          isEmpty = false;
        });
      } else {
        setState(() {
          isEmpty = true;
        });
      }
    });
    super.initState();
  }

  updateUI() {
    setState(() {});
  }

  addEmoji(String emoji) {
    String newText = emoji;
    final updatedText = controller.text + newText;
    controller.value = controller.value.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }

  removeEmoji() {
    final updatedText = controller.text;

    List<String> c = updatedText.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
    c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
    final text = c.join(); //aaabc
    controller.value = controller.value.copyWith(
      text: text,
      selection: const TextSelection.collapsed(
        offset: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    double emojiMinSize = size.height * 0.05;
    double emojiMaxSize = size.height * 0.20;
    return Material(
      color: Colors.black.withAlpha(150),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: size.height,
          maxWidth: size.width,
          minWidth: size.width,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        CommentSection.instance().hide();
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 204, 201, 201),
                            radius: Platform.isAndroid
                                ? kBottomNavigationBarHeight / 3.5
                                : 90 / 3.5,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: controller,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  //  suffixIconColor: Colors.grey,

                                  suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            //todo
                                            addEmoji('@');
                                          },
                                          child: const Icon(
                                            Icons.alternate_email,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              //todo
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.mood,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ]),
                                  hintText: 'Add comment...',
                                  fillColor:
                                      const Color.fromARGB(255, 204, 201, 201),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                            ),
                          ),
                        ),
                        isEmpty
                            ? const SizedBox()
                            : const Icon(
                                Icons.send,
                              )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: isExpanded ? emojiMaxSize : emojiMinSize,
                    child: isExpanded
                        ? SizedBox(
                            width: double.infinity,
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                // Do something when emoji is tapped
                                addEmoji(emoji.emoji);
                              },
                              onBackspacePressed: () {
                                // Backspace-Button tapped logic
                                // Remove this line to also remove the button in the UI
                                removeEmoji();
                              },
                              config: Config(
                                  enableSkinTones: false,
                                  columns: 9,
                                  emojiSizeMax: 32 *
                                      (Platform.isIOS
                                          ? 1.30
                                          : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.black,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.black,
                                  progressIndicatorColor: Colors.blue,
                                  backspaceColor: Colors.red,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  //  noRecents: "No Recents",
                                  // noRecentsStyle: const TextStyle(
                                  //     fontSize: 20, color: Colors.black26),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              addNewEmojiFromShortBar('😀'),
                              addNewEmojiFromShortBar('😂'),
                              addNewEmojiFromShortBar('😍'),
                              addNewEmojiFromShortBar('😘'),
                              addNewEmojiFromShortBar('😟'),
                              addNewEmojiFromShortBar('😇'),
                              addNewEmojiFromShortBar('🤒'),
                              addNewEmojiFromShortBar('😠'),
                              addNewEmojiFromShortBar('❤️'),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addNewEmojiFromShortBar(String emoji) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          addEmoji(emoji);
        },
        child: Text(
          emoji,
          style: TextStyle(
            color: const Color.fromARGB(255, 236, 155, 33),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

// class EmojiPages extends StatefulWidget {
//   const EmojiPages({
//     Key? key,
//     required this.controller,
//     required this.updateOverlay,
//   }) : super(key: key);
//   final TextEditingController controller;
//   final VoidCallback updateOverlay;
//   @override
//   State<EmojiPages> createState() => _EmojiPagesState();
// }

// class _EmojiPagesState extends State<EmojiPages> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: PageView.builder(
//             onPageChanged: (value) => setState(() {
//               currentIndex = value;
//             }),
//             scrollDirection: Axis.horizontal,
//             itemCount: 4,
//             controller: PageController(
//               initialPage: 0,
//               viewportFraction: 1,
//               keepPage: true,
//             ),
//             itemBuilder: (context, index) => GestureDetector(
//               onTap: (() {
//                 widget.controller.text = '😀👨‍👧‍👦😜';
//                 // widget.updateOverlay();
//               }),
//               child: const Icon(
//                 Icons.emoji_emotions,
//                 color: Color.fromARGB(255, 236, 155, 33),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//             bottom: 4,
//             top: 10,
//           ),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(4, (index) => dots(index: index)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget dots({required int index}) {
//     final mIndex = index;
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: CircleAvatar(
//         backgroundColor: currentIndex == mIndex ? Colors.red : Colors.grey,
//         radius: 5,
//       ),
//     );
//   }
// }
