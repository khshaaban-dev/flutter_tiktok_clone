import 'dart:convert';

class CommentModel {
  static const String commentUserUid = 'userUid';
  static const String commentCommentId = 'commentId';
  static const String commentUserName = 'userName';
  static const String commentCommentText = 'commentText';
  static const String commentDateTime = 'dateTime';
  static const String commentImageUrl = 'imageUrl';
  static const String commentLikeCount = 'likeCount';
  static const String commentReplayCount = 'replayCount';

  final String userUid;
  final String commentId;
  final String userName;
  final String commentText;
  final String dateTime;
  final String imageUrl;
  final int likeCount;
  final int replayCount;
  CommentModel({
    required this.userUid,
    required this.commentId,
    required this.userName,
    required this.commentText,
    required this.dateTime,
    required this.imageUrl,
    required this.likeCount,
    required this.replayCount,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userUid': userUid});
    result.addAll({'commentId': commentId});
    result.addAll({'userName': userName});
    result.addAll({'commentText': commentText});
    result.addAll({'dateTime': dateTime});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'likeCount': likeCount});
    result.addAll({'replayCount': replayCount});

    return result;
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userUid: map['userUid'] ?? '',
      commentId: map['commentId'] ?? '',
      userName: map['userName'] ?? '',
      commentText: map['commentText'] ?? '',
      dateTime: map['dateTime'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      likeCount: map['likeCount']?.toInt() ?? 0,
      replayCount: map['replayCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  CommentModel copyWith({
    String? userUid,
    String? commentId,
    String? userName,
    String? commentText,
    String? dateTime,
    String? imageUrl,
    int? likeCount,
    int? replayCount,
  }) {
    return CommentModel(
      userUid: userUid ?? this.userUid,
      commentId: commentId ?? this.commentId,
      userName: userName ?? this.userName,
      commentText: commentText ?? this.commentText,
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      replayCount: replayCount ?? this.replayCount,
    );
  }
}
