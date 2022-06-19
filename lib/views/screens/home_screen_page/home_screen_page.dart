
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';


class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  bool showLoading = false;
  int currentPage = 0;
  int firstTime = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MainHomeScreenPage();
    // return BlocProvider(
    //   lazy: false,
    //   create: (context) => VideosBloc()
    //     ..add(
    //       VideosStartFeatchEvent(),
    //     ),
    //   child: BlocBuilder<VideosBloc, VideosState>(
    //     builder: (context, state) {
    //       if (state.loading) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    //       if (state.videos != null) {
    //         return NotificationListener<ScrollNotification>(
    //           onNotification: (scrollNotification) {
    //             //when user scroll to down becuse down means forward (to the top)
    //             if (pageController.position.userScrollDirection ==
    //                 ScrollDirection.forward) {
    //               setState(() {
    //                 showLoading = false;
    //               });
    //               //the setState function
    //             }
    //             // (to the down)
    //             if (pageController.position.userScrollDirection ==
    //                     ScrollDirection.reverse &&
    //                 currentPage == 1) {
    //               if (firstTime == 0 && pageController.position.outOfRange) {
    //                 firstTime = 1;

    //                 return true;
    //               }
    //               if (firstTime == 1) {
    //                 setState(() {
    //                   showLoading = true;
    //                 });
    //                 //ToDo
    //                 // send event to bloc
    //                 Future.delayed(const Duration(seconds: 2), () {
    //                   if (currentPage == 1) {
    //                     setState(() {
    //                       showLoading = false;
    //                     });
    //                   }
    //                   //setState function
    //                 });
    //                 return false;
    //               }
    //             }

    //             return false;
    //           },
    //           child: Column(children: [
    //             Flexible(
    //               child: AnimatedContainer(
    //                 duration: const Duration(milliseconds: 500),
    //                 child: PageView.builder(
    //                   key: const PageStorageKey('homeList'),
    //                   onPageChanged: (value) {
    //                     setState(() {
    //                       currentPage = value;
    //                     });
    //                     if (value != 1) {
    //                       firstTime = 0;
    //                     }
    //                   },
    //                   physics: const BouncingScrollPhysics(),
    //                   scrollDirection: Axis.vertical,
    //                   controller: pageController,
    //                   itemCount: state.videos!.length,
    //                   itemBuilder: (context, index) => VideoPlayerItem(
    //                     videoModel: state.videos!.getVideoMoles()![index],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             showLoading
    //                 ? Padding(
    //                     padding: EdgeInsets.only(
    //                       top: 10.0,
    //                       bottom: Platform.isAndroid
    //                           ? kBottomNavigationBarHeight + 10
    //                           : 90 + 10,
    //                     ),
    //                     child: SizedBox(
    //                       width: 22.w,
    //                       height: 22.w,
    //                       child: const CircularProgressIndicator(),
    //                     ),
    //                   )
    //                 : const SizedBox()
    //           ]),
    //         );
    //       } else if (state.videos!.isEmpty) {
    //         return const Center(
    //           child: Text(
    //             'There is No Video yet',
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //         );
    //       }
    //       return const Center(
    //         child: Text('NO Internet Connection'),
    //       );
    //     },
    //   ),
    // );
  }
}

class MainHomeScreenPage extends StatefulWidget {
  static const String route = '/MainHomeScreenPage';
  const MainHomeScreenPage({Key? key}) : super(key: key);

  @override
  State<MainHomeScreenPage> createState() => _MainHomeScreenPageState();
}

class _MainHomeScreenPageState extends State<MainHomeScreenPage> {
  bool isFouYou = true;
  void changeTabs({required bool isForYou}) {
    setState(() {
      isFouYou = isForYou;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: HomeTabs(
            isForYou: isFouYou,
            changTabs: changeTabs,
          )),
      body: Stack(
        fit: StackFit.expand,
        children:  const [
          ChannelVideoPreviewItem(),
          Align(
            //   alignment: Alignment(0.0, 1.0),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }
}
