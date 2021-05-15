import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/marketIndex.dart';
import 'package:dio/dio.dart';
import 'package:simulador/models/movers.dart';

class PortfolioService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<List<MarketIndexModel>> fetchIndexes() async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/^DJI,^GSPC,^IXIC');    
    return MarketIndexModel.toList(response.data);
  }

  Future<List<MarketIndexModel>> fetchCommodities() async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/GCUSD,SIUSD,CLUSD');    
    return MarketIndexModel.toList(response.data);
  }

  Future<List<MarketMover>> fetchWinnersAndLosers() async {
    final Response<dynamic> gainers = await _httpLibrary.financialModelRequest('/api/v3/gainers');
    final Response<dynamic> losers = await _httpLibrary.financialModelRequest('/api/v3/losers');  

    // print(gainers[0]);  



    final MarketMover gainer = MarketMover.fromJson(gainers.data[0]);
    final MarketMover loser = MarketMover.fromJson(losers.data[0]);

    return [gainer, loser];
  }

}