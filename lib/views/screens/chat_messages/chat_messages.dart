import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../channel_details/channel_details.dart';

class ChatMessages extends StatefulWidget {
  static const String route = '/chatMessages';
  const ChatMessages({Key? key}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ChannelDetails.route,
              );
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                focusNode.unfocus();
              },
              child: const Center(
                child: Text(
                  'list chat messages between \nthis user and another user.',
                  maxLines: 2,
                ),
              ),
            ),
          ),
          sendMessageArea(),
        ],
      ),
    );
  }

  Widget sendMessageArea() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
          border:
              BorderDirectional(top: BorderSide(color: Colors.grey.shade200))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.black,
                ),
                fillColor: Colors.grey.shade200,
                hintText: 'Send a message...',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                focusNode.unfocus();
              },
              icon: const Icon(
                Icons.send,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
