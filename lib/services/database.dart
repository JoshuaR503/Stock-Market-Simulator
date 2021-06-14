import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulador/models/holdingData.dart';
import 'package:simulador/models/orderData.dart';
import 'package:simulador/models/orderType.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/services/auth.dart';
import 'dart:convert';

class Database {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Stream<DocumentSnapshot> get database {
    return _database
    .collection("users")
    .doc(_auth.getUser.uid)
    .snapshots();
  }

  Future<StockHolding> stockHolding(String ticker) async{
    final docRef = await _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .get();

    final StockHolding holding = StockHolding
      .toList(docRef['holdings'])
      .firstWhere((holding) => holding.ticker == ticker);

    return holding;
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

  Future<void> handleBuyOrder({OrderData orderData}) async {

    /// Get document database.
    final documentReference = await _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .get();

    /// Get document data.
    final List<StockHolding> holdings = StockHolding.toList(documentReference['holdings']);

    /// See if holding exists.
    final singleHolding = holdings.where((holding) => holding.ticker == orderData.ticker);

    /// If holding exists.
    if (singleHolding.isNotEmpty) {

      /// New quantity
      final quantity = int.parse(singleHolding.first.quanity) + int.parse(orderData.quanity);

      /// New Basis cost = Current Cost / Shares
      final baseCost = singleHolding.first.baseCost + orderData.baseCost / quantity;
      
      /// New total cost.
      final totalCost = singleHolding.first.totalCost + orderData.totalCost;

      /// Select find holding index in List.
      final int index = holdings.indexOf(singleHolding.first);

      /// Update holding list.
      holdings[index] = StockHolding(
        ticker: orderData.ticker,
        orderType: 'buy',
        quanity: quantity.toString(),
        baseCost: baseCost,
        totalCost: totalCost
      );


      final jsonHoldings =  holdings
        .map((e) => e.toJson())
        .toList();

      print(jsonHoldings);
      
      await _database
      .collection("users")
      .doc(_auth.getUser.uid)
      .set({ "holdings": jsonHoldings}, SetOptions(merge: true));
    }
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