import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'custom_message_feild.dart';
import 'search_to_find_user.dart';

typedef ToggleUserSelected = void Function(int index);
showSearchBottomSheet(BuildContext context, {bool isMainScreen = false}) {
  return showMaterialModalBottomSheet(
    useRootNavigator: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(12),
        topEnd: Radius.circular(12),
      ),
    ),
    context: context,
    builder: (context) {
      return SendToSelectedUsersWidget(
        isMainScreen: isMainScreen,
      );

      /////////////////////////
    },
  );
}

class SendToSelectedUsersWidget extends StatefulWidget {
  final bool isMainScreen;
  const SendToSelectedUsersWidget({
    Key? key,
    this.isMainScreen = false,
  }) : super(key: key);

  @override
  State<SendToSelectedUsersWidget> createState() =>
      _SendToSelectedUsersWidgetState();
}

class _SendToSelectedUsersWidgetState extends State<SendToSelectedUsersWidget> {
  bool isUserSelected = false;
  List<int> users = [];
  void toggleUserSelected(int index) {
    if (!isUserSelected) {
      setState(() {
        isUserSelected = true;
      });
      users.add(index);
    } else {
      if (users.contains(index)) {
        users.remove(index);
      } else {
        users.add(index);
      }
      if (users.isEmpty) {
        setState(() {
          isUserSelected = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: isUserSelected
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.55,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1      //// 1
            Expanded(
              flex: 1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Send to',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BuildSendToOrShareToAvatar(
                                index: 1,
                                toggleUserSelected: toggleUserSelected,
                                context: context,
                                userImgeUrl: 'assets/images/person.png',
                                text: 'Ibrahim',
                                color: const Color.fromARGB(255, 112, 49, 194),
                              ),
                              BuildSendToOrShareToAvatar(
                                index: 2,
                                toggleUserSelected: toggleUserSelected,
                                context: context,
                                userImgeUrl: 'assets/images/person.png',
                                text: 'Ali',
                                color: const Color.fromARGB(255, 112, 49, 194),
                              ),
                              BuildSendToOrShareToAvatar(
                                index: 3,
                                toggleUserSelected: toggleUserSelected,
                                context: context,
                                userImgeUrl: 'assets/images/person.png',
                                text: 'mohamed',
                                color: const Color.fromARGB(255, 112, 49, 194),
                              ),
                              BuildSendToOrShareToAvatar(
                                index: 4,
                                toggleUserSelected: toggleUserSelected,
                                context: context,
                                userImgeUrl: 'assets/images/person.png',
                                text: 'Ahmed',
                                color: const Color.fromARGB(255, 112, 49, 194),
                              ),
                              BuildSendToOrShareToAvatar(
                                index: 5,
                                toggleUserSelected: toggleUserSelected,
                                context: context,
                                userImgeUrl: 'assets/images/person.png',
                                text: 'Ahmed',
                                color: const Color.fromARGB(255, 112, 49, 194),
                              ),
                              BuildSendToOrShareToAvatar(
                                  toggleUserSelected: toggleUserSelected,
                                  context: context,
                                  iconData: Icons.search,
                                  text: 'More',
                                  color: Colors.blue,
                                  onPressed: () {
                                    searchToFindUser(
                                      context: context,
                                      title: 'Send to',
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),

            //1 end
            isUserSelected
                ? Expanded(
                    child: customMessageFeild(
                      context: context,
                      showBottomMessageErea: true,
                    ),
                  )
                : Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Share to',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10.w,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BuildSendToOrShareToAvatar(
                                              context: context,
                                              iconData: Icons.attach_file,
                                              text: 'Copy link',
                                              color: const Color.fromARGB(
                                                  255, 112, 49, 194),
                                            ),
                                            BuildSendToOrShareToAvatar(
                                              context: context,
                                              iconData: Icons.move_to_inbox,
                                              text: 'Email',
                                              color: const Color.fromARGB(
                                                  255, 112, 49, 194),
                                            ),
                                            BuildSendToOrShareToAvatar(
                                              context: context,
                                              iconData: Icons.sms,
                                              text: 'SMS',
                                              color: const Color.fromARGB(
                                                  255, 112, 49, 194),
                                            ),
                                            BuildSendToOrShareToAvatar(
                                              context: context,
                                              iconData: Icons.send_outlined,
                                              text: 'Message',
                                              color: const Color.fromARGB(
                                                  255, 112, 49, 194),
                                            ),
                                            BuildSendToOrShareToAvatar(
                                              context: context,
                                              iconData: Icons.more_horiz,
                                              text: 'Copy link',
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Divider(
                            thickness: 1,
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey.shade300,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BuildSendToOrShareToAvatar(
                                    context: context,
                                    iconData: Icons.flag,
                                    text: 'Report',
                                    iconColor: Colors.black,
                                    color: Colors.grey.shade300,
                                  ),
                                  if (widget.isMainScreen) ...[
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.heart_broken_outlined,
                                      text: 'Not intersting',
                                      color: Colors.grey.shade300,
                                      iconColor: Colors.black,
                                    ),
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.download,
                                      text: 'Save video',
                                      iconColor: Colors.black,
                                      color: Colors.grey.shade300,
                                    ),
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.edgesensor_low_outlined,
                                      text: 'Duet',
                                      iconColor: Colors.black,
                                      color: Colors.grey.shade300,
                                    ),
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.reduce_capacity_sharp,
                                      text: 'Reach',
                                      iconColor: Colors.black,
                                      color: Colors.grey.shade300,
                                    ),
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.save,
                                      text: 'Add to favorite',
                                      iconColor: Colors.black,
                                      color: Colors.grey.shade300,
                                    )
                                  ] else
                                    BuildSendToOrShareToAvatar(
                                      context: context,
                                      onPressed: () {},
                                      iconData: Icons.move_to_inbox,
                                      text: 'Block',
                                      iconColor: Colors.black,
                                      color: Colors.grey.shade300,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: BorderDirectional(
                                  top: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          )
                        ])),
          ]),
    );
  }
}

class BuildSendToOrShareToAvatar extends StatefulWidget {
  final BuildContext context;
  final String text;
  final IconData? iconData;
  final Color? color;
  final String? userImgeUrl;
  final VoidCallback? onPressed;
  final ToggleUserSelected? toggleUserSelected;
  final int? index;
  final Color? iconColor;
  const BuildSendToOrShareToAvatar({
    Key? key,
    required this.context,
    required this.text,
    this.iconData,
    this.color,
    this.userImgeUrl,
    this.onPressed,
    this.toggleUserSelected,
    this.index,
    this.iconColor,
  }) : super(key: key);

  @override
  State<BuildSendToOrShareToAvatar> createState() =>
      _BuildSendToOrShareToAvatarState();
}

class _BuildSendToOrShareToAvatarState
    extends State<BuildSendToOrShareToAvatar> {
  bool isSelcted = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.18,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.onPressed != null) {
                Navigator.pop(context);
                widget.onPressed!();
              } else {
                setState(() {
                  isSelcted = !isSelcted;
                });
                widget.toggleUserSelected!(widget.index!);
              }
            },
            child: CircleAvatar(
              radius: 20.w,
              backgroundImage: widget.userImgeUrl == null
                  ? null
                  : AssetImage(widget.userImgeUrl!),
              backgroundColor: widget.color ?? Colors.white,
              child: widget.userImgeUrl == null
                  ? Icon(
                      widget.iconData!,
                      color: widget.iconColor ?? Colors.white,
                    )
                  : isSelcted
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            color: Colors.black45,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        )
                      : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                softWrap: false,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                )),
          )
        ],
      ),
    );
  }
}
