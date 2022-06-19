import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowersScreen extends StatefulWidget {
  static const String route = '/FollowersScreen';
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'channel name',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
                color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: const [
              Tab(
                child: Text('Following 256k'),
              ),
              Tab(
                child: Text('Followers 225.5k'),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(children: [
          ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(
                        'assets/images/person.png',
                      ),
                    ),
                    title: const Text(
                      'channel name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: const Text(
                      'user name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 0,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Follow',
                      ),
                    ),
                  )),
          ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(
                        'assets/images/person.png',
                      ),
                    ),
                    title: const Text(
                      'channel name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: const Text(
                      'user name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 0,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Follow',
                      ),
                    ),
                  ))
        ]),
      ),
    );
  }
}
