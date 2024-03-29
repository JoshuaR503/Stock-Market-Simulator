import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/marketPrices.dart';
import 'package:dio/dio.dart';

class HoldingsService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<List<MarketPricesModel>> fetchHoldings(String tickers) async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest("/api/v3/quote/$tickers"); 
    final holdings = MarketPricesModel.toList(response.data);

    /// Sort by price change.
    holdings.sort( (a, b) => b.change.compareTo(a.change) );
    return holdings;
  }
}