import 'package:flutter/material.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({Key? key}) : super(key: key);

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  FocusNode focusNode = FocusNode();
  late TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                focusNode.unfocus();
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            title: const Text(
              'Username',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  focusNode.unfocus();
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Save',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              autofocus: true,
              focusNode: focusNode,
              minLines: 1,
              maxLines: 1,
              maxLength: 30,
              decoration: InputDecoration(
                hintText: 'name',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              buildCounter: (
                context, {
                required int currentLength,
                required int? maxLength,
                required bool isFocused,
              }) {
                return Container(
                  // alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.8,
                      ),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'www.tiktok.com/',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: '@username1',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Usernames can contain only, numbers,\nunderscores, and periods. Changing your username will\nalso change your profile link.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
