import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String url);

  Future<http.Response> postApiResponse(String url, dynamic data);
}
