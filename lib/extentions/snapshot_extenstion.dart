import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/models.dart';

extension GetAsVideoModels<T> on Iterable<T> {
  List<VideoModel>? getVideoMoles() => map(
        (T e) => VideoModel.fromMap(
          (e as DocumentSnapshot<Map<String, dynamic>>).data()!,
        ),
      ).toList();
}
