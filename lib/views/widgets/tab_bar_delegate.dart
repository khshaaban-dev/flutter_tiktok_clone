
import 'package:flutter/material.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBar child;
  TabBarDelegate({
    required this.child,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: !overlapsContent ? 1 : 0,
          ),
        ),
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height - 10;

  @override
  double get minExtent => child.preferredSize.height - 10;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
