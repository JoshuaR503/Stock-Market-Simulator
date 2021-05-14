import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:simulador/services/database.dart';
import 'package:simulador/shared/common/portfolioCard.dart';

class PortfolioBalance extends StatelessWidget {

  final bool actionEnabled;

  PortfolioBalance({
    this.actionEnabled
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database().cashBalance,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return PortfolioCard(
            title: "Valor de la cartera:",
            value: '\$${NumberFormat().format(snapshot.data['cash'])}',
            actionEnabled: actionEnabled,
            action: () {
              Navigator.pushNamed(context, '/holdings');
            },
          );
        } else {
          return Container();
        }
      }
    );
  }
}