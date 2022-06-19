import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_uitls/search_to_find_user.dart';

class DirectMessages extends StatefulWidget {
  static const String route = '/DirectMessages';
  const DirectMessages({Key? key}) : super(key: key);

  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Direct Messages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                searchToFindUser(
                  context: context,
                  title: 'New chat',
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: const Center(
        child: Text(
          'previas Messages between\n this user and others...',
          maxLines: 2,
        ),
      ),
    );
  }
}
