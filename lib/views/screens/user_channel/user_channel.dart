import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class UserChannel extends StatefulWidget {
  static const String route = '/UserChannel';

  const UserChannel({
    Key? key,
  }) : super(key: key);

  @override
  State<UserChannel> createState() => _UserChannelState();
}

class _UserChannelState extends State<UserChannel> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              pinned: true,
              centerTitle: true,
              title: Text(
                'user name',
                style: GoogleFonts.acme(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SettingsScreen.route,
                    );
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
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildButton(
                          text: 'Edit Profile',
                          bBorderColor: Colors.grey.shade300,
                          context: context,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              EditProfile.route,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, FavoritesScreen.route);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            // ignore: prefer_const_constructors
                            child: Icon(
                              Icons.bookmark_outline,
                              // size: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    padding:
                        EdgeInsets.only(left: 30.w, right: 20.w, bottom: 8.h),
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
                    Tab(
                      icon: Icon(Icons.lock),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              ChannelVideosTap(),
              ChannelVideosTap(),
              ChannelVideosTap(),
            ],
          ),
        ),
      ),
    );
  }
}
