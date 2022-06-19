import 'package:flutter/material.dart';

import 'widgets.dart';

class ChannelVideosTap extends StatelessWidget {
  const ChannelVideosTap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 40,
      itemBuilder: (context, index) => VideoImagePreview(
        index: index,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
    );
  }
}
