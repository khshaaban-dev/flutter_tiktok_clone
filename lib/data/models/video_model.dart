import 'dart:convert';

class VideoModel {
  static String videoDtateTimeFeild = 'dateTime';
  final String userName;
  final String userProfielUrl;
  final String uid; // user id
  final String id; // video id
  final String dateTime;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnailUrl;

  final int likesCount;
  final int shareCount;
  final int conmmentsCount;
  VideoModel({
    this.userName = '',
    this.userProfielUrl = '',
    this.uid = '',
    this.id = '',
    this.dateTime = '',
    this.songName = '',
    this.caption = '',
    this.videoUrl = '',
    this.thumbnailUrl = '',
    this.likesCount = 0,
    this.shareCount = 0,
    this.conmmentsCount = 0,
  });

  VideoModel copyWith({
    String? userName,
    String? userProfielUrl,
    String? uid,
    String? id,
    String? dateTime,
    String? songName,
    String? caption,
    String? videoUrl,
    String? thumbnailUrl,
    int? likesCount,
    int? shareCount,
    int? conmmentsCount,
  }) {
    return VideoModel(
      userName: userName ?? this.userName,
      userProfielUrl: userProfielUrl ?? this.userProfielUrl,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      songName: songName ?? this.songName,
      caption: caption ?? this.caption,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      likesCount: likesCount ?? this.likesCount,
      shareCount: shareCount ?? this.shareCount,
      conmmentsCount: conmmentsCount ?? this.conmmentsCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'userProfielUrl': userProfielUrl});
    result.addAll({'uid': uid});
    result.addAll({'id': id});
    result.addAll({'dateTime': dateTime});
    result.addAll({'songName': songName});
    result.addAll({'caption': caption});
    result.addAll({'videoUrl': videoUrl});
    result.addAll({'thumbnailUrl': thumbnailUrl});
    result.addAll({'likesCount': likesCount});
    result.addAll({'shareCount': shareCount});
    result.addAll({'conmmentsCount': conmmentsCount});

    return result;
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      userName: map['userName'] ?? '',
      userProfielUrl: map['userProfielUrl'] ?? '',
      uid: map['uid'] ?? '',
      id: map['id'] ?? '',
      dateTime: map['dateTime'] ?? '',
      songName: map['songName'] ?? '',
      caption: map['caption'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      likesCount: map['likesCount']?.toInt() ?? 0,
      shareCount: map['shareCount']?.toInt() ?? 0,
      conmmentsCount: map['conmmentsCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideoModel(userName: $userName, userProfielUrl: $userProfielUrl, uid: $uid, id: $id, dateTime: $dateTime, songName: $songName, caption: $caption, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, likesCount: $likesCount, shareCount: $shareCount, conmmentsCount: $conmmentsCount)';
  }
}
