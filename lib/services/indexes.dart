import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/marketIndex.dart';
import 'package:dio/dio.dart';

class MarketService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<List<MarketIndexModel>> fetchIndexes() async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/^DJI,^GSPC,^IXIC');    
    return MarketIndexModel.toList(response.data);
  }

  Future<List<MarketIndexModel>> fetchCommodities() async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/GCUSD,SIUSD,CLUSD');    
    return MarketIndexModel.toList(response.data);
  }

}