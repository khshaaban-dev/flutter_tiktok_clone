import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/constants.dart';
import '../models/video_model.dart';

class VideoRepostory {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  VideoRepostory({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

//get all Videos
  Future<Iterable<DocumentSnapshot>?> getAllVideos() async {
    try {
      final CollectionReference<Map<String, dynamic>> collectionRef =
          _firestore.collection(videosCollection);
      final collectionDocuments = await collectionRef.get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
          collectionDocuments.docs;
      final doc = data.map((e) => e).toList();

      return doc;
    } catch (e) {
      throw Exception('Error while featch videos');
    }
  }

  // method for add like or remove like
  Future<bool> toggleLike({String? videoId = 'e2a8cX5WUk3ERxlmEKXa'}) async {
    final userUid = _auth.currentUser!.uid;

    final docRef = _firestore
        .collection(videosCollection)
        .doc(videoId)
        .collection(likesCount)
        .doc(userUid);
    final DocumentSnapshot? docData = await docRef.get();
    final WriteBatch batch = _firestore.batch();
    if (docData?.data() != null) {
      try {
        batch.delete(docRef);
        batch.update(
            docRef.parent.parent!, {likesCount: FieldValue.increment(-1)});
        batch.commit();
        return true;
      } on Exception catch (_) {
        return false;
      }
    } else {
      try {
        batch.set(docRef, {likeModelUid: userUid});
        batch.update(
            docRef.parent.parent!, {likesCount: FieldValue.increment(1)});
        batch.commit();
        return true;
      } on Exception catch (_) {
        return false;
      }
    }
  }

  // get more videos
  Future<Iterable<DocumentSnapshot>?> getMoreVideos({
    required DocumentSnapshot documentSnapshot,
  }) async {
    try {
      final data = await _firestore
          .collection(videosCollection)
          .orderBy(VideoModel.videoDtateTimeFeild)
          .startAfterDocument(documentSnapshot)
          .limit(10)
          .get();

      return data.docs;
    } on SocketException catch (_) {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Error');
    }
  }
}
