import 'package:flutter/material.dart';

class NotificationOverlay {
  //singlton object
  static final NotificationOverlay _shared = NotificationOverlay._intit();
  NotificationOverlay._intit();
  factory NotificationOverlay.instance() => _shared;
  //show method

  // hide method

  // link entery to overly screen
  OverlayState? _overlayState;
  RenderBox? _renderBox;
  OverlayEntry? _entry;
  RenderBox? _childRenderBox;
  Size? size;
  void showNotificationOverlay({
    required BuildContext context,
    required GlobalKey key,
  }) async {
    if (_entry != null) {
      return;
    } else {
      _overlayState = Overlay.of(context);
      _renderBox = context.findRenderObject() as RenderBox;
      size = _renderBox!.size;
      _buildEntery(
        size: size!,
        key: key,
      );
      _overlayState!.insert(_entry!);
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () {
          _entry!.remove();
          _entry = null;
        },
      );
    }
  }

  // overlayEntery
  _buildEntery({
    required Size size,
    required GlobalKey key,
  }) {
    _childRenderBox = key.currentContext!.findRenderObject() as RenderBox;
    _entry = OverlayEntry(
      builder: ((context) => Positioned(
            top: _childRenderBox!.size.height,
            right: 0,
            left: 0,
            child: Material(
              color: Colors.black.withOpacity(0.6),
              child: AnimatedOpacity(
                curve: Curves.easeIn,
                opacity: 0.8,
                duration: const Duration(
                  seconds: 1,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  // height: size.height / 7,
                  child: const Text(
                    'Link copied',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
