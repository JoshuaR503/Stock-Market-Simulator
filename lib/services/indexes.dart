import 'package:dio/dio.dart';
import 'package:simulador/models/marketIndex.dart';

class MarketService {  

  Future<Response> fetchData({Uri uri}) async {
    return await Dio().getUri(uri);
  }

  // Makes an HTTP request to any endpoint from Financial Modeling Prep API.
  Future<Response> financialModelRequest(String endpoint ) async {
    final Uri uri = Uri.https('financialmodelingprep.com', endpoint, {
      'apikey': '0849e57c93849847c2aa34f38e03d28c'
    });
    
    return await Dio().getUri(uri);
  }

  Future<List<MarketIndexModel>> fetchIndexes() async {
    final Response<dynamic> response = await this.financialModelRequest('/api/v3/quote/^DJI,^GSPC,^IXIC');    
    return MarketIndexModel.toList(response.data);
  }

}