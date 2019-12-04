import 'dart:convert';
import 'dart:io';

class Request {
  static void requestWithHttpClient(
      String domain, String path, Map<String, String> params) async {
    var httpClient = HttpClient();
    var uri = Uri.http(domain, path, params);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
  }
}