import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants/constants.dart';
import '../exeptions/auth_exceptions.dart';
import '../models/user_model.dart';

class AuthRepostory {
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  AuthRepostory({
    FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
    FirebaseFirestore? firebaseFirestore,
  })  : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _storage = firebaseStorage ?? FirebaseStorage.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // sign up
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String imagePath,
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedUserInfo = credential.user;
      final newUser = UserModel(
        name: name,
        email: email,
        imageUrl: imagePath,
        uid: signedUserInfo!.uid,
      );
      final signeduser = await uploadUserInfo(userModel: newUser);
      return signeduser;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  // sign in
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedUserInfo = credential.user;

      final signeduser =
          await getUserInfoFromFirestore(uid: signedUserInfo!.uid);
      return signeduser;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  // // check if the user it's first time login
  // Future<bool> _isNewUser({required String uid}) async {
  //   final userDoc = _firestore.collection('users').doc(uid);
  //   if (userDoc.id.isNotEmpty) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // sign in with google
  // Future<UserModel?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       // handle the auth with firebase
  //       UserCredential? userCredential =
  //           await _auth.signInWithCredential(credential);
  //       print(userCredential.user);
  //       final User? user = userCredential.user!;

  //       final isNewUser = await _isNewUser(uid: user!.uid);
  //       if (isNewUser) {
  //         final UserModel userModel = UserModel(
  //           name: user.displayName ?? 'name',
  //           email: user.email!,
  //           imageUrl: user.photoURL ?? '',
  //           // 'https://en.wikipedia.org/wiki/File:Google_%22G%22_Logo.svg.png',
  //           uid: user.uid,
  //         );
  //         final userData = await uploadUserInfo(userModel: userModel);
  //         return userData;
  //       } else {
  //         final userDate = await getUserInfoFromFirestore(uid: user.uid);
  //         return userDate;
  //       }
  //     } else {
  //       return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw AuthError.from(e);
  //   } catch (e) {
  //     throw AuthError.from(
  //       FirebaseAuthException(
  //         code: e.toString(),
  //       ),
  //     );
  //   }
  // }
  ////////////////////////////////////////////////////////////////////////
  Future<UserModel?> signInWithGoogle() async {
    try {
      // 1  show popup to choose google account
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      // 2 get user auth information
      GoogleSignInAuthentication? _authentication =
          await googleSignInAccount?.authentication;
      // 3 make user provider object to pass it to firebase auth
      final credential = GoogleAuthProvider.credential(
        idToken: _authentication?.idToken,
        accessToken: _authentication?.accessToken,
      );
      // handle the auth with firebase
      UserCredential? userCredential =
          await _auth.signInWithCredential(credential);
      // save user info on firestore
      final User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          final userModel = await uploadUserInfo(
              userModel: UserModel(
            name: user.displayName ?? 'name',
            email: user.email ?? 'email',
            imageUrl: user.photoURL ?? 'imageUrl',
            uid: user.uid,
          ));
          return userModel;
        } else {
          final userModel = await getUserInfoFromFirestore(uid: user.uid);
          return userModel;
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  //log out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

// get user info from firestore
  Future<UserModel> getUserInfoFromFirestore({
    required String uid,
  }) async {
    final ref = await _firestore.collection('users').doc(uid).get();
    // ignore: avoid_print
    print(ref.data());
    final Map<String, dynamic>? data = ref.data() as Map<String, dynamic>;
    final UserModel userModel;
    if (data!.isNotEmpty) {
      userModel = UserModel.fromJson(data);
      return userModel;
    }
    return UserModel.empty();
  }

// upload user image to firebase storage
  Future<String> uploadImageToStorage({
    required String uid,
    required String imageUrl,
  }) async {
    File file = File(imageUrl);
    final Reference reference =
        _storage.ref().child(storageFolderName).child(uid);

    TaskSnapshot uploadTask = await reference.putFile(file);
    final String url = await uploadTask.ref.getDownloadURL();
    return url;
  }

// fires when user sign up upload user info to firestore
  Future<UserModel> uploadUserInfo({
    required UserModel userModel,
  }) async {
    final String url = await uploadImageToStorage(
      uid: userModel.uid,
      imageUrl: userModel.imageUrl,
    );
    final user = userModel.copyWith(
      imageUrl: url,
    );
    await _firestore.collection('users').doc(userModel.uid).set(
          user.toJson(),
        );

    return user;
  }
}
