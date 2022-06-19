import 'package:flutter/material.dart';

class IconBounceAnimation extends StatefulWidget {
  final bool isFav;
  const IconBounceAnimation({
    Key? key,
    this.isFav = false,
  }) : super(key: key);

  @override
  State<IconBounceAnimation> createState() => _IconBounceAnimationState();
}

class _IconBounceAnimationState extends State<IconBounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isFav = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticIn,
      )),
      child: GestureDetector(
        onTap: () {
          animationController
              .forward()
              .then((value) => animationController.reverse());
        },
        onTapDown: (details) {
          setState(() {
            isFav = !isFav;
          });
          //    animationController.reverse();
        },
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : Colors.grey,
          //   size: 14.sp,
        ),
      ),
    );
  }
}
