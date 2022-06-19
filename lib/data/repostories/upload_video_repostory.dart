import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../constants/constants.dart';
import '../exeptions/auth_exceptions.dart';
import '../models/models.dart';
  
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoRepostory {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UploadVideoRepostory({
    FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
    FirebaseFirestore? firebaseFirestore,
  })  : _storage = firebaseStorage ?? FirebaseStorage.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _auth = firebaseAuth ?? FirebaseAuth.instance;

  /// constants

  // for storage buckets
  final String videosBucket = 'videos';
  final String thumbnailBucket = 'thumbnail';
/////////////////////////////////////////////////////////////////////////////

  Future<void> uploadVideo({
    required File file,
    required String videoPath,
    required String songName,
    required String caption,
  }) async {
    try {
      final String uid = _auth.currentUser!.uid;
      //commpressed video after upload it
      final File? commpressedVideo =
          await _getCommpressVideo(videoPath: videoPath);

      // get thumbnail for this video
      final File thumbnailFile = await _getVideoThumbnail(videoPath: videoPath);

      // upload video to storage
      final String videoUrl = await _uploadFileToStorage(
        uid: uid,
        file: commpressedVideo!,
        bucket: videosBucket,
      );

      // upload thumbnail to storage
      final String thumbnailUrl = await _uploadFileToStorage(
        uid: uid,
        bucket: thumbnailBucket,
        file: thumbnailFile,
      );

      // upload video info to firestor
      await _uploadVideoData(
        uid: uid,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        songName: songName,
        caption: caption,
      );
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  //compressed video file
  Future<File?> _getCommpressVideo({required String videoPath}) async {
    final video = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    return video!.file;
  }

  // get video thumbnail
  Future<File> _getVideoThumbnail({required String videoPath}) async {
    final File thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // upload file to storage
  Future<String> _uploadFileToStorage({
    required String bucket,
    required String uid,
    required File file,
  }) async {
    final ref = _storage.ref().child(bucket).child(uid);
    final UploadTask uploadTask = ref.putFile(file);
    final TaskSnapshot snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }

  // set video data in firestore
  Future<void> _uploadVideoData({
    required String uid,
    required String videoUrl,
    required String thumbnailUrl,
    required String songName,
    required String caption,
  }) async {
    final userDocSnapshot =
        await _firestore.collection(usersCollection).doc(uid).get();
    final userDoc =
        UserModel.fromJson(userDocSnapshot.data() as Map<String, dynamic>);

    final VideoModel videoModel = VideoModel().copyWith(
      userName: userDoc.name,
      uid: uid,
      id: const Uuid().v4(),
      userProfielUrl: userDoc.imageUrl,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      songName: songName,
      caption: caption,
    );
    await _firestore.collection(videosCollection).add(
          videoModel.toMap(),
        );
  }
}
