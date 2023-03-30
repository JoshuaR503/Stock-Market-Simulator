
import 'package:dio/dio.dart';

class HttpLibrary {
  Future<Response> fetchData({Uri uri}) async {
    return await Dio().getUri(uri);
  }

  // Makes an HTTP request to any endpoint from Financial Modeling Prep API.
  Future<Response> financialModelRequest(String endpoint ) async {
    final Uri uri = Uri.https('financialmodelingprep.com', endpoint, {
      'apikey': ''
    });
    
    return await Dio().getUri(uri);
  }

  Future<Response> iexRequest(String endpoint ) async {
    final Uri uri = Uri.https('cloud.iexapis.com', endpoint, {
      'token': ''
    });
    
    return await Dio().getUri(uri);
  }
}