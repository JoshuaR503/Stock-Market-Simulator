import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulador/services/auth.dart';

class PortfolioService {

  final String uid;

  PortfolioService({
    this.uid
  });

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final AuthService auth = AuthService();



  /// Update user data in Firestore.
  Future<DocumentSnapshot> getCashAvailable() async {
    final DocumentSnapshot snapshot = await _database
    .collection('users')
    .doc(auth.getUser.uid)
    .get();

    return snapshot;
  }
}