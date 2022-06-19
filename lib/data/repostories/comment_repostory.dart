import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constants.dart';
import '../models/comment_model.dart';

class CommentRepostory {
  final FirebaseFirestore _firestore;
  CommentRepostory({
    FirebaseFirestore? firebaseFirestore,
  }) : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // add comment
  Future<bool> addComment(
      {required String documentId, required CommentModel commentModel}) async {
    try {
      final docReference =
          _firestore.collection(videosCollection).doc(documentId);
      // increment comment count filed in doc
      final newDocComment = _firestore
          .collection(videosCollection)
          .doc(documentId)
          .collection(commentsCollection)
          .doc(); // add new comment to comments collection
      // Get a new write batch
      final batch = _firestore.batch();

      batch.set(
        newDocComment,
        commentModel.toMap(),
      );

      batch.update(
        docReference,
        {commentsCount: FieldValue.increment(1)},
      );
      // Commit the batch
      batch.commit();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  // delete comment
  Future<bool> deleteComment(
      {required String commentDocId, required String documentId}) async {
    try {
      final commentsCountDoc = _firestore
          .collection(videosCollection)
          .doc(documentId)
          .collection(commentsCollection)
          .doc(commentDocId);
      final docReference =
          _firestore.collection(videosCollection).doc(documentId);

      final WriteBatch batch = _firestore.batch();
      // delete comment doc
      batch.delete(docReference);
      // decrement comments count
      batch.update(commentsCountDoc, {commentsCount: FieldValue.increment(-1)});
      batch.commit();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  // update comment
  Future<bool> updateComment(
      {required String documentId, required String comment}) async {
    try {
      _firestore
          .collection(videosCollection)
          .doc(documentId)
          .update({CommentModel.commentCommentText: comment});
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
  // get all comments

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllComments(
      {required String videoid}) {
    try {
      return _firestore
          .collection(videosCollection)
          .doc(videoid)
          .collection(commentsCollection)
          .limit(20)
          .snapshots();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
