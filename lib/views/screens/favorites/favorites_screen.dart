import 'package:flutter/material.dart';
import 'package:tik_tik_clone_all_fetures/views/widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  static const String route = '/FavoritesScreen';
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Favorites',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade400,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(
                text: 'Videos',
              ),
              Tab(
                text: 'Hashtages',
              ),
              Tab(
                text: 'Sounds',
              ),
            ],
          ),
        ),
       
        body: const TabBarView(
          children: [
            ChannelVideosTap(),
            ChannelVideosTap(),
            ChannelVideosTap(),
          ],
        ),
      ),
    );
  }
}
