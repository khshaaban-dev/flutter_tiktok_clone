import 'package:flutter/material.dart';
import 'package:tik_tik_clone_all_fetures/logic/utils/clipboard_oprations.dart';
import 'package:tik_tik_clone_all_fetures/views/dialogs/notification_overlay.dart';
import 'package:tik_tik_clone_all_fetures/views/screens/edit_profile/edit_bio.dart';
import 'package:tik_tik_clone_all_fetures/views/screens/edit_profile/edit_username.dart';

import 'edit_name.dart';

class EditProfile extends StatelessWidget {
  static const String route = '/EditProfile';

  EditProfile({Key? key}) : super(key: key);
  final GlobalKey appBarKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(0.0).copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Padding(
                      padding: EdgeInsets.all(22.0),
                      child: SimpleDialog(
                        children: [
                          SimpleDialogOption(child: Text('Tacke photo')),
                          SimpleDialogOption(
                            child: Text('Select from Gallery'),
                          ),
                          SimpleDialogOption(
                            child: Text('View photo'),
                          ),
                          SimpleDialogOption(
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  // backgroundImage: AssetImage('assets/images/person.png'),
                  radius: 40,
                  child: ClipOval(
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Image.asset('assets/images/person.png'),
                        ),
                        const Center(
                          child: Icon(
                            Icons.camera_enhance,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Change Photo'),
              ),

              // todo list name username bio
              buildListTile(
                context: context,
                title: 'Name',
                text: 'androflut212',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditName(),
                    ),
                  );
                },
              ),
              buildListTile(
                context: context,
                title: 'Username',
                text: 'androflut212',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return const EditUserName();
                      }),
                    ),
                  );
                },
              ),
              buildListTile(
                context: context,
                title: '',
                text: 'tiktok.com/jpooflut212',
                iconData: Icons.content_copy_outlined,
                onPressed: () {
                  copyToClipboard(
                    text: 'tiktok.com/jpooflut212',
                  );
                  NotificationOverlay.instance().showNotificationOverlay(
                    context: context,
                    key: appBarKey,
                  );
                },
              ),
              buildListTile(
                  context: context,
                  title: 'Bio',
                  text: 'androflut212',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return const EditBio();
                        }),
                      ),
                    );
                  }),
              Divider(
                thickness: 0.8,
                color: Colors.grey.shade400,
              )
            ],
          ),
        ),
      ),
    );
  }

  buildListTile({
    required BuildContext context,
    required String title,
    required String text,
    IconData? iconData,
    VoidCallback? onPressed,
  }) =>
      ListTile(
        onTap: onPressed,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const SizedBox(
              width: 22,
            ),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Icon(
          iconData ?? Icons.arrow_forward_ios_rounded,
          size: 16,
        ),
      );
}
