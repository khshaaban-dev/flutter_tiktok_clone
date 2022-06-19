import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/screens.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.route:
      return MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      );
    case LoginScreen.route:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case MainScreen.route:
      return MaterialPageRoute(
        builder: (_) => const MainScreen(),
      );
    case ChannelScreen.route:
      return MaterialPageRoute(
        builder: (_) => const ChannelScreen(),
      );
    case ChatMessages.route:
      return MaterialPageRoute(
        builder: (_) => const ChatMessages(),
      );
    case ChannelDetails.route:
      return MaterialPageRoute(
        builder: (_) => const ChannelDetails(),
      );
    case FollowersScreen.route:
      return MaterialPageRoute(
        builder: (_) => const FollowersScreen(),
      );
    case InboxScreen.route:
      return MaterialPageRoute(
        builder: (_) => const InboxScreen(),
      );
    case DirectMessages.route:
      return MaterialPageRoute(
        builder: (_) => const DirectMessages(),
      );
    case ChannelVideosPreview.route:
      return MaterialPageRoute(
        builder: (_) => const ChannelVideosPreview(),
      );
    case FavoritesScreen.route:
      return MaterialPageRoute(
        builder: (_) => const FavoritesScreen(),
      );
    case EditProfile.route:
      return MaterialPageRoute(
        builder: (_) => EditProfile(),
      );
    case SettingsScreen.route:
      return MaterialPageRoute(
        builder: (_) => const SettingsScreen(),
      );
    case ConfirmAddVideoScreen.route:
      return MaterialPageRoute(builder: (_) {
        final arogs = settings.arguments as Map<String, dynamic>;
        final vfile = arogs['videoFile'] as File;
        final vpath = arogs['videoPath'] as String;
        return ConfirmAddVideoScreen(
          videoFile: vfile,
          videoPath: vpath,
        );
      });

    default:
      return MaterialPageRoute(
        builder: (_) => const UnkownScreen(),
      );
  }
}
