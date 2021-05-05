

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {

  /// Firebase tools.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  /// Google Sign.
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  /// Current user.
  User get getUser =>  _auth.currentUser;

  /// Check if Apple Sign In is available.
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  Stream<User> get user => _auth.authStateChanges();

  /// Anonymous login. 
  Future<User> annLogin() async {

    final UserCredential result = await _auth.signInAnonymously();
    final User user = result.user;

    updateUserData(user);

    return user;
  }

  Future<User> signInWithEmailAndPassword({
    @required String email,
    @required String password
  }) async {

    try {

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      final User user = userCredential.user;

      return user;
    } catch (e) {
      return null;
    }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //     return null;
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //     return null;
    //   }
    // }
  }


  /// Google Sign in.
  Future<User> googleSignIn() async {
    try {

      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

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

  Future<User> signInWithFacebook() async {
    
    try {
      // Trigger the sign-in flow
      final LoginResult facebookLogin = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLogin.accessToken.token);

      final UserCredential result = await _auth.signInWithCredential(facebookAuthCredential);

      final User user = result.user;

       // Update user data
      updateUserData(user);

      // Once signed in, return the UserCredential
      return user;

    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Apple Sign in.
  Future<User> appleSignIn() async {
    try {

      final AuthorizationResult appleResult = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);


      if (appleResult.error != null) {
        // handle errors from Apple here
        print(appleResult.error);
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      final UserCredential firebaseResult = await _auth.signInWithCredential(credential);
      final User user = firebaseResult.user;

      // Optional, Update user data in Firestore
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Update user data in Firestore.
  Future<void> updateUserData(User user) {
    final DocumentReference reportRef = _database.collection('users').doc(user.uid);
    final Map<String, dynamic> data = {
      'uid': user.uid, 
      'lastActivity': DateTime.now()
    };

    return reportRef.set(data, SetOptions(merge: true));

  }
  
  Future<void> signOut() {
    return _auth.signOut();
  }
}