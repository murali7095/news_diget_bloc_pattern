

import 'package:http/http.dart' as http;

import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<http.Response> getApiResponse(String url,
      {Map<String, String>? headers}) async {
    final http.Response getApiResponseData;
    try {
      getApiResponseData = await http.get(
          Uri.parse(
            url,
          ),
          headers: headers);

      return getApiResponseData;
    } catch (e) {
      rethrow;
    }
  }

/*  @override
  Future<Either<CustomException, dynamic>> getApiResponse(String url) async{
    dynamic jsonResponseData;
   try{
     final response =
         await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
     if(response)
     jsonResponseData = jsonResponse(response);

   }catch(e){
     log(e.toString());
   }
  }*/
/*
  @override
  Future postApiResponse(String url, data) async {
    dynamic jsonResponseData;
    try {
      final response = await http.post(
          Uri.parse(
            url,
          ),
          body: data);
      jsonResponseData = jsonResponse(response);
    } on SocketException {
      throw InternetException("No Internet, Please try again");
    }
    return jsonResponseData;
  }*/

  @override
  Future<http.Response> postApiResponse(String url, data,
      {Map<String, String>? headers}) async {
    final http.Response postApiResponseData;
    try {
      postApiResponseData = await http.post(
          Uri.parse(
            url,
          ),
          headers: headers,
          body: data);
      return postApiResponseData;
    } catch (e) {
      rethrow;
    }
  }
}
