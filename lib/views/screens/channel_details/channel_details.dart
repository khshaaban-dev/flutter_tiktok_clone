import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelDetails extends StatefulWidget {
  static const String route = '/ChannelDetails';

  const ChannelDetails({Key? key}) : super(key: key);

  @override
  State<ChannelDetails> createState() => _ChannelDetailsState();
}

class _ChannelDetailsState extends State<ChannelDetails> {
  bool isMute = false;
  bool isPined = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: BorderDirectional(
              bottom: BorderSide(color: Colors.grey.shade300)),
          centerTitle: true,
          title: const Text(
            'Details',
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/person.png',
                      width: 40.h,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text(
                          'channel name ',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'الاسم ممكن بالعربى',
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //todo
                      // navigate to channel page
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade500,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.6,
              endIndent: 12,
              indent: 12,
            ),
            SwitchListTile.adaptive(
                title: Text(
                  'Mute notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
                value: isMute,
                onChanged: (onChanged) {
                  setState(() {
                    isMute = onChanged;
                  });
                }),
            SwitchListTile.adaptive(
                title: Text(
                  'Pin to top',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
                value: isPined,
                onChanged: (onChanged) {
                  setState(() {
                    isPined = onChanged;
                  });
                }),
            ListTile(
              title: Text(
                'Report',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Block',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
              ),
              trailing: IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ));
  }
}
