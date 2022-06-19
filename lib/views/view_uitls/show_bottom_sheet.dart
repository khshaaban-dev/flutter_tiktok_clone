import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../dialogs/comment_section.dart';
import '../widgets/comment_card.dart';

showCommentsBottomSheet(BuildContext context,) {
  return showMaterialModalBottomSheet(
    useRootNavigator: false,
    context: context,
    builder: (context) => SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(children: [
                  const Expanded(child: Center(child: Text('2k comments'))),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ))
                ]),
                const SizedBox(
                  //  height: 150,
                  child: SingleChildScrollView(child: CommentCard()),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: BorderDirectional(top: BorderSide(color: Colors.grey))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: CircleAvatar(
                    radius: Platform.isAndroid
                        ? kBottomNavigationBarHeight / 3.5
                        : 90 / 3.5,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //////////////////////////////////////
                      CommentSection.instance()
                          .show(context: context, text: '');
                      ///////////////////////////////////
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Add comment...',
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.alternate_email),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.mood),
                                ],
                              )
                            ]),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 199, 197, 197),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
