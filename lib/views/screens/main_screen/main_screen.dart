import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../add_video/add_video.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class MainScreen extends StatefulWidget {
  static const String route = '/MainScreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  logout() {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutEvent(),
    );
  }

  late PageController controller;
  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
      keepPage: true,
    );
    super.initState();
  }

  void goBack() {
    controller.previousPage(
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        key: const PageStorageKey('mainList'),
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: [
          mainPage(),
          ChannelScreen(
            goBack: goBack,
          ),
        ]);
  }

  Widget mainPage() {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreenPage(),
          Center(child: Text('Search')),
          AddVideoView(),
          InboxScreen(),
          UserChannel(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: currentIndex > 0 ? Colors.white : Colors.transparent,
        selectedItemColor: currentIndex > 0 ? Colors.black : Colors.white,
        unselectedItemColor: currentIndex > 0 ? Colors.grey : Colors.white70,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedIconTheme: IconThemeData(size: 33.sp),
        selectedIconTheme: IconThemeData(size: 33.sp),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Discover'),
          BottomNavigationBarItem(
            icon: CustomTiktokIcon(currentIndex: currentIndex),
            label: '',
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.inbox_rounded,
              ),
              label: 'Inbox'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Me'),
        ],
      ),
    );
  }
}
