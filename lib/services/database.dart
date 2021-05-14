import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulador/services/auth.dart';

class Database {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Stream<DocumentSnapshot> get cashBalance {
    // return _firestore.collection("books").snapshots().map((event) => event.documents
    //     .map((DocumentSnapshot documentSnapshot) => Book(name: documentSnapshot.data["name"]))
    //     .toList());

    // await _database
    // .collection('users')
    // .doc(auth.getUser.uid)
    // .get();

    return _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .snapshots();
  }
}