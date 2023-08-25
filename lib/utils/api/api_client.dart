import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../api/api_interceptor.dart';

class ApiClient {
  static const String BASE_URL = "https://www.mocky.io/";
  final String? tempUrl;

  ApiClient({this.tempUrl});

  http.Client client() {
    http.Client client =  InterceptedClient
        .build(interceptors: [ApiInterceptor()]);
    return client;
  }

  String url(String? route) {
    if(tempUrl!=null){
      return "$tempUrl$route";
    }
    return "$BASE_URL$route";
  }
}
