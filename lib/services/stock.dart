import 'package:simulador/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';

class StockService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<StockStats> fetchStockStats() async {
    final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/COST/stats');
    return StockStats.fromJson(response.data);
  }

  Future<StockQuote> fetchStockQuote() async {
    final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/COST/quote');
    return StockQuote.fromJson(response.data);
  }
}