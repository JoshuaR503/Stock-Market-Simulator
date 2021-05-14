import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulador/models/holdingData.dart';
import 'package:simulador/models/orderData.dart';
import 'package:simulador/models/orderType.dart';
import 'package:simulador/services/auth.dart';

class Database {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Stream<DocumentSnapshot> get cashBalance {
    return _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .snapshots();
  }

  Future<void> changeCashbalance({
    double orderValue,
    OrderType orderType
  }) async {
    final currentCashbalance = await _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .get();

    final double futureCashbalance = orderType == OrderType.buy 
      ? currentCashbalance['cash'] - orderValue 
      : currentCashbalance['cash'] + orderValue;

    _database
    .collection("users")
    .doc(_auth.getUser.uid)
    .set({"cash": futureCashbalance}, SetOptions(merge: true));

    return null;
  }

  Future<void> updateOrderHistory({
    OrderData orderData,
    HoldingData holdingData,
  }) async {

    final currentOrderHistory = await _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .get();

    
    final List currentOrders = currentOrderHistory['orders'];
    
    currentOrders.add(orderData.toJson());

    await _database
    .collection("users")
    .doc(_auth.getUser.uid)
    .set({ "orders": FieldValue.arrayUnion(currentOrders)},  SetOptions(merge: true));

    final List currentHoldings = currentOrderHistory['holdings'];
    currentHoldings.add(holdingData.toJson());

    await _database
    .collection("users")
    .doc(_auth.getUser.uid)
    .set({ "holdings": FieldValue.arrayUnion(currentHoldings)},  SetOptions(merge: true));
  
    return null;
  }
}