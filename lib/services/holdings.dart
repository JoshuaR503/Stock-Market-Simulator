import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/marketPrices.dart';
import 'package:dio/dio.dart';
import 'package:simulador/services/database.dart';

class HoldingsService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<List<MarketPricesModel>> fetchHoldings() async {
    final tickersFromDB = await Database().holdings;

    print(tickersFromDB);

    if (tickersFromDB.isNotEmpty) {
      final tickers = tickersFromDB.join(',');
      final Response<dynamic> response = await _httpLibrary.financialModelRequest("/api/v3/quote/$tickers"); 

      return MarketPricesModel.toList(response.data);
    } else {
      return null;
    }
  }



}