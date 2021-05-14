
import 'package:dio/dio.dart';

class HttpLibrary {
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

  Future<Response> iexRequest(String endpoint ) async {
    final Uri uri = Uri.https('cloud.iexapis.com', endpoint, {
      'token': 'pk_2c98731b2745499abe6d8045867b7e7f'
    });
    
    return await Dio().getUri(uri);
  }
}