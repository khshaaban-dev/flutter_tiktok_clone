import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_uitls/show_bottom_sheet.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ChannelScreen extends StatefulWidget {
  static const String route = '/channelScreen';
  final VoidCallback? goBack;
  const ChannelScreen({
    Key? key,
    this.goBack,
  }) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      pinned: true,
                      centerTitle: true,
                      leading: BackButton(
                        color: Colors.black,
                        onPressed: widget.goBack,
                      ),
                      title: Text(
                        'user name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            showCommentsBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40.h,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: const AssetImage(
                                'assets/images/person.png',
                              ),
                            ),
                          ),
                          Text(
                            '@drmabrokattia',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FollowersCount(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      FollowersScreen.route,
                                    );
                                  },
                                  count: '1k',
                                  text: 'Following',
                                ),
                                buildDivider(),
                                FollowersCount(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      FollowersScreen.route,
                                    );
                                  },
                                  count: '22.5k',
                                  text: 'Follwers',
                                ),
                                buildDivider(),
                                FollowersCount(
                                  onPressed: () {},
                                  count: '656.4m',
                                  text: 'Likes',
                                ),
                              ],
                            ),
                          ),
                          isFollowing
                              ? Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildButton(
                                          text: 'Message',
                                          bBorderColor: Colors.grey.shade300,
                                          context: context,
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, ChatMessages.route);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                isFollowing = false;
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300)),
                                            child: const Icon(
                                                Icons.person_add_disabled),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : buildButton(
                                  text: 'Follow',
                                  context: context,
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      isFollowing = true;
                                    });
                                  }),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'bio :Reload already in progress, ignoring request',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: 30.w, right: 20.w, bottom: 8.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attachment,
                                  size: 16.sp,
                                ),
                                Expanded(
                                  child: Text(
                                    "https:oioihodffggjryjryjjtjtjtjtjtjtjtjtdffggjryjryjjtjtjtjtjtjtjtjtdffggjryjryjjtjtjtjtjtjtjtjtdffggjryjryjjtjtjtjtjtjtjtjt",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TabBarDelegate(
                        child: const TabBar(
                          indicatorColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.menu),
                            ),
                            Tab(
                              icon: Icon(Icons.favorite_border_outlined),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
              body:
                  const TabBarView(physics: BouncingScrollPhysics(), children: [
                ChannelVideosTap(),
                ChannelVideosTap(),
              ])),
        ),
      ),
    );
  }
}
