import 'package:simulador/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';

class StockService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<StockStats> fetchStockStats(String ticker) async {
    final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/$ticker/stats');
    return StockStats.fromJson(response.data);
  }

  Future<StockQuote> fetchStockQuote(String ticker) async {
    final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/$ticker/quote');
    return StockQuote.fromJson(response.data);
  }

  Future<List<StockChart>> fetchStockChart(String ticker) async {
    final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/$ticker/chart/6m');
    return StockChart.toList(response.data);
  }

}