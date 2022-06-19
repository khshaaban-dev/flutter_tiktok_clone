import 'package:flutter/material.dart';

class EditBio extends StatefulWidget {
  const EditBio({Key? key}) : super(key: key);

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
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
              'Bio',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18,
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
              minLines: 5,
              maxLines: 5,
              maxLength: 80,
              decoration: InputDecoration(
                hintText: 'Enter your bio',
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
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      top: BorderSide(color: Colors.grey.shade300, width: 0.8),
                    ),
                  ),
                  width: double.infinity,
                  child: Text(
                    '$currentLength / $maxLength',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                );
              },
            ),
          )),
    );
  }
}
