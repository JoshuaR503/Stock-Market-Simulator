import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/marketIndex.dart';
import 'package:dio/dio.dart';
import 'package:simulador/models/movers.dart';

class PortfolioService {  

  final HttpLibrary _httpLibrary = HttpLibrary();

  Future<List<MarketIndexModel>> fetchIndexes({String indexes = '^DJI,^GSPC,^IXIC'}) async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/$indexes');    
    return MarketIndexModel.toList(response.data);
  }

  Future<List<MarketIndexModel>> fetchCommodities({String commodities = 'GCUSD,SIUSD,CLUSD'}) async {
    final Response<dynamic> response = await _httpLibrary.financialModelRequest('/api/v3/quote/$commodities');    
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