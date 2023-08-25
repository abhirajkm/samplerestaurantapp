import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      if (data.headers['content-type'] != 'multipart/form-data') {
        data.headers['content-type'] = 'application/json';
      }



      //final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJkNDE3MTViOC1hNjJkLTQ3M2YtYWQ2My1lZDM3M2VjNTM1NmYiLCJOYW1lIjoiQXN3aW4gMiIsIk1vYmlsZSI6IjgxMTMwMDA1NTEiLCJFbWFpbCI6ImZkaGNqamhoQGRnZy5jb20iLCJDdXN0b21lciI6IkNmREo4QkVUTlhLV0dnVkhxcE9TMF9nZEJubDdXSzhwR3Q2MFYxaENqX2tXbWJKc2dUbHhkWFpXaEZKYl9DV21pQXBIZXlOM3RsVndUT0NnTG1ReW9PMXZPOUVRR01IQW81YmFsenZIa25FMC1oUm9jbjQ2Zl8xZUxBbDY5eWNZS29IaVZnIiwiZXhwIjoxNjMwNTUwMDAwLCJpc3MiOiJodHRwOi8vYm9va2l0c3Fsd2ViYXBwLmF6dXJld2Vic2l0ZXMubmV0LyIsImF1ZCI6Imh0dHA6Ly9ib29raXRzcWx3ZWJhcHAuYXp1cmV3ZWJzaXRlcy5uZXQvIn0.vZHrLjaSCyL8oSJ00F7MVCKhZoVv_FM0LOOOZFjAf5Y";

      // final token =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoia2t1bWFyQGVtZ2VuZXguY29tICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiLCJqdGkiOiIwY2JkZDVkYi0wZDJmLTRiNjMtODgyNC03ZGI5ZjBmZjVmNzciLCJyb2xlIjoiQXBwbGljYXRpb25BZG1pbiIsImV4cCI6MTYwNjMwMTUwMywiaXNzIjoiaHR0cHM6Ly90ZWxlbWVkLmVtZ2VuZXguYXBwL2FwaSIsImF1ZCI6Imh0dHBzOi8vdGVsZW1lZC5lbWdlbmV4LmFwcC9hcGkifQ.bxhrnC2c51PQ1jMkci_Ivd8YLMDPVZkKDtZcIqKxrwg";



      // data.headers['BusinessToken'] = "mELirpUhRYksFj7k8/XBcQ==";
      
    } catch (e) {
      print(e);
    }

    log(
        "------->Request Start\n${data.method}: ${data.baseUrl} \nHeaders: ${data.headers}\nBody: \n${data.body}\n<----------Request End");

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log(

        "------->Response Start\n${data.method}${data.statusCode}: ${data.url} \nBody: \n${data.body}\n<----------Response End",);

    return data;
  }
}
