import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens.dart';

class InboxScreen extends StatefulWidget {
  static const String route = '/InboxScreen';
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  GlobalKey globalKey = GlobalKey();

  bool isClicked = false;
  int currentIndex = 0;
  OverlayEntry? entry;
  RenderBox? renderBox;
  StreamController<int>? streamController;
  List<String> showOptions = [
    'All activity',
    'Likes',
    'Comments',
    'Mentions',
    'Followers',
    'From TikTok',
  ];
  void showOverlayList() {
    renderBox = context.findRenderObject() as RenderBox;
    entry = OverlayEntry(
      builder: _listOverlayEntrey,
      maintainState: true,
    );
    streamController = StreamController<int>();
    Overlay.of(context)!.insert(entry!);
  }

  void closeOverlayEntery() {
    streamController?.close();
    streamController = null;
    entry?.remove();
    entry = null;
  }

  Widget _listOverlayEntrey(BuildContext context) {
    RenderBox? obRenderBox =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    // Offset offset = obRenderBox.localToGlobal(Offset.zero);
    return Positioned(
      top: obRenderBox.size.height,
      child: GestureDetector(
        onTap: () {
          closeOverlayEntery();
          setState(() {
            isClicked = false;
          });
        },
        child: Material(
          color: Colors.transparent,
          elevation: 2,
          child: Container(
            alignment: Alignment.topCenter,
            constraints: BoxConstraints(
              maxHeight: renderBox!.size.height,
              minHeight: renderBox!.size.height,
              maxWidth: renderBox!.size.width,
              minWidth: renderBox!.size.width,
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                height: constraints.maxHeight * 0.4,
                width: constraints.maxWidth,
                child: StreamBuilder<int>(
                    stream: streamController!.stream,
                    initialData: currentIndex,
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customListTile(
                            icon: Icons.inbox,
                            title: 'All activity',
                            index: 0,
                          ),
                          customListTile(
                              icon: Icons.favorite, title: 'Likes', index: 1),
                          customListTile(
                              icon: Icons.inbox, title: 'Comments', index: 2),
                          customListTile(
                              icon: Icons.inbox, title: 'Mentions', index: 3),
                          customListTile(
                              icon: Icons.inbox, title: 'Followers', index: 4),
                          customListTile(
                              icon: Icons.inbox,
                              title: 'From TikTok',
                              index: 5),
                        ],
                      );
                    }),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget customListTile({
    required int index,
    required IconData icon,
    required String title,
  }) {
    int widgetIndex = index;
    return Expanded(
      child: ListTile(
        onTap: () {
          streamController!.add(currentIndex);
          closeOverlayEntery();
          setState(() {
            currentIndex = widgetIndex;
            isClicked = !isClicked;
          });
        },
        leading: Icon(
          icon,
          color: currentIndex == widgetIndex ? Colors.black : Colors.grey[500],
          //  size: 16.sp,
        ),
        title: Text(
          title,
          style: TextStyle(
              color:
                  currentIndex == widgetIndex ? Colors.black : Colors.grey[500],
              fontSize: 14.sp),
        ),
        trailing: Icon(
          Icons.done,
          color: currentIndex == widgetIndex ? Colors.red : Colors.transparent,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    streamController?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          key: globalKey,
          shape: BorderDirectional(
            bottom: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                if (isClicked) {
                  closeOverlayEntery();
                  setState(() {
                    isClicked = false;
                  });
                }
                Navigator.pushNamed(context, DirectMessages.route);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: 5.9,
                  child: const Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
          title: GestureDetector(
            onTap: () {
              if (isClicked) {
                closeOverlayEntery();
                setState(() {
                  isClicked = false;
                });
              } else {
                showOverlayList();
                setState(() {
                  isClicked = true;
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showOptions[currentIndex],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Icon(
                  isClicked ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
          )),
      body: const Center(
          child: Text(
        'list of all actions likes comments or follow back to this user channel.',
        maxLines: 2,
      )),
    );
  }
}
