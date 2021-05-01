

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get getUser =>  _auth.currentUser;

  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();


  Stream<User> get user => _auth.authStateChanges();

  Future<User> annLogin() async {

    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;

    updateUserData(user);

    return user;
  }

  Future<User> googleSignIn() async {
    try {

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      // Update user data
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<User> appleSignIn() async {
    try {

      final AuthorizationResult appleResult = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        // handle errors from Apple here
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      UserCredential firebaseResult = await _auth.signInWithCredential(credential);
      User user = firebaseResult.user;

      // Optional, Update user data in Firestore
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);

    return reportRef.set(
      {
        'uid': user.uid, 
        'lastActivity': DateTime.now()
      },
      SetOptions(merge: true)
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }





}